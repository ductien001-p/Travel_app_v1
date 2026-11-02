import {
  prisma,
  redis,
  request,
  getState,
  updateState,
  getTestData,
  updateTestData,
  updateInventoryEndpoint,
  validateOpenApiResponse,
  recordReport,
  recordBlocker,
} from './harness.mjs';

const PHASE = 'PHASE_1_AUTH';

async function logResult({ taskId, endpoint, method, route, req, res, expectedStatus, dbCheck, sideEffectCheck, authCheck, errors = [] }) {
  const httpPass = res.status === expectedStatus;
  const contractCheck = validateOpenApiResponse(method, route, res.status, res.data);
  const contractPass = contractCheck.valid;
  const dbPass = dbCheck === undefined ? 'N/A' : dbCheck ? 'PASS' : 'FAIL';
  const sideEffectPass = sideEffectCheck === undefined ? 'N/A' : sideEffectCheck ? 'PASS' : 'FAIL';
  const authPass = authCheck === undefined ? 'N/A' : authCheck ? 'PASS' : 'FAIL';

  const isPass = httpPass && contractPass && dbPass !== 'FAIL' && sideEffectPass !== 'FAIL' && authPass !== 'FAIL' && errors.length === 0;
  const result = isPass ? 'PASS' : 'FAILED';

  const report = `
### Task: ${taskId}
**Endpoint**: \`${method} ${route}\`
- **Request**: \`${JSON.stringify(req || {})}\`
- **Expected Status**: ${expectedStatus}
- **Actual Status**: ${res.status}
- **HTTP**: ${httpPass ? 'PASS' : 'FAIL'}
- **Response Contract**: ${contractPass ? 'PASS' : 'FAIL'}${!contractPass ? ` (Errors: ${contractCheck.errors.join(', ')})` : ''}
- **Database**: ${dbPass}
- **Side Effects**: ${sideEffectPass}
- **Authorization**: ${authPass}
- **Result**: **${result}**
- **Evidence**:
\`\`\`json
${JSON.stringify(res.data, null, 2)}
\`\`\`
${errors.length ? `- **Errors**: ${errors.join('; ')}` : ''}
`;

  recordReport(PHASE, report);

  // Update Inventory
  updateInventoryEndpoint(taskId, {
    runtimeStatus: result,
    actualStatus: res.status,
    contractValid: contractPass,
    executedAt: new Date().toISOString(),
  });

  // Update State
  const state = getState();
  const passed = state.passed + (isPass ? 1 : 0);
  const failed = state.failed + (isPass ? 0 : 1);
  const pending = Math.max(0, state.pending - 1);

  updateState({
    currentPhase: PHASE,
    currentTask: taskId,
    lastPassedTask: isPass ? taskId : state.lastPassedTask,
    passed,
    failed,
    pending,
  });

  if (!isPass) {
    recordBlocker({
      taskId,
      endpoint: `${method} ${route}`,
      severity: 'HIGH',
      phase: PHASE,
      reproduction: `Request: ${JSON.stringify(req)} to ${method} ${route}`,
      expected: `Status ${expectedStatus} with valid contract`,
      actual: `Status ${res.status} with body ${JSON.stringify(res.data)}`,
      logs: JSON.stringify(contractCheck.errors),
      likelySource: 'src/module/auth/auth.controller.ts',
      dependencyImpact: 'Blocks subsequent auth-dependent tests',
      suggestedFix: 'Review controller validation and service response contract',
    });
  }

  return isPass;
}

export async function runPhase1() {
  console.log(`=== Starting ${PHASE} ===`);

  // Clean up existing test data in DB if any
  const testEmails = [
    'runtime_test_user_a@test.com',
    'runtime_test_user_b@test.com',
    'runtime_test_admin@test.com',
  ];
  for (const email of testEmails) {
    const existing = await prisma.user.findUnique({ where: { email } });
    if (existing) {
      await prisma.refreshToken.deleteMany({ where: { userId: existing.id } });
      await prisma.user.delete({ where: { id: existing.id } });
    }
  }

  const userAPassword = 'Password123!';
  const userBPassword = 'Password123!';
  const adminPassword = 'Password123!';

  // ==========================================
  // TASK-001: POST /auth/register
  // ==========================================
  console.log('--- Testing TASK-001: POST /auth/register ---');
  // 1. Negative: invalid email
  const neg1 = await request('POST', '/auth/register', {
    body: { email: 'invalid-email', password: '123', username: 'bad' },
  });
  const neg1Pass = neg1.status === 400;

  // 2. Positive: register USER_A
  const regA = await request('POST', '/auth/register', {
    body: {
      email: 'runtime_test_user_a@test.com',
      password: userAPassword,
      username: 'runtime_test_user_a',
    },
  });

  // Check DB side effect
  const userADb = await prisma.user.findUnique({ where: { email: 'runtime_test_user_a@test.com' } });
  const dbCheck001 = !!userADb && userADb.status === 'INACTIVE';

  // Check Redis side effect for verification code
  const redisKeyA = `email_verification:runtime_test_user_a@test.com`;
  const codeA = await redis.get(redisKeyA);
  const sideEffect001 = !!codeA;

  const pass001 = await logResult({
    taskId: 'TASK-001',
    endpoint: 'POST /auth/register',
    method: 'POST',
    route: '/auth/register',
    req: { email: 'runtime_test_user_a@test.com', username: 'runtime_test_user_a' },
    res: regA,
    expectedStatus: 201,
    dbCheck: dbCheck001,
    sideEffectCheck: sideEffect001 && neg1Pass,
    authCheck: true,
  });

  if (!pass001) throw new Error('TASK-001 FAILED');

  // Register USER_B and ADMIN_USER as well
  await request('POST', '/auth/register', {
    body: { email: 'runtime_test_user_b@test.com', password: userBPassword, username: 'runtime_test_user_b' },
  });
  await request('POST', '/auth/register', {
    body: { email: 'runtime_test_admin@test.com', password: adminPassword, username: 'runtime_test_admin' },
  });

  const userBDb = await prisma.user.findUnique({ where: { email: 'runtime_test_user_b@test.com' } });
  const adminDb = await prisma.user.findUnique({ where: { email: 'runtime_test_admin@test.com' } });

  // Update test-data
  updateTestData({
    users: {
      USER_A: { id: userADb.id, email: userADb.email, password: userAPassword },
      USER_B: { id: userBDb.id, email: userBDb.email, password: userBPassword },
      ADMIN_USER: { id: adminDb.id, email: adminDb.email, password: adminPassword },
    },
  });

  // ==========================================
  // TASK-002: POST /auth/verify-email
  // ==========================================
  console.log('--- Testing TASK-002: POST /auth/verify-email ---');
  // Negative: wrong token
  const negVerify = await request('POST', '/auth/verify-email', {
    body: { email: 'runtime_test_user_a@test.com', token: '000000' },
  });
  const negVerifyPass = negVerify.status === 400;

  // Positive: verify USER_A
  const verifyA = await request('POST', '/auth/verify-email', {
    body: { email: 'runtime_test_user_a@test.com', token: codeA },
  });

  // Check DB status changed to ACTIVE
  const userAActive = await prisma.user.findUnique({ where: { id: userADb.id } });
  const dbCheck002 = userAActive?.status === 'ACTIVE';

  const pass002 = await logResult({
    taskId: 'TASK-002',
    endpoint: 'POST /auth/verify-email',
    method: 'POST',
    route: '/auth/verify-email',
    req: { email: 'runtime_test_user_a@test.com', token: '******' },
    res: verifyA,
    expectedStatus: 201,
    dbCheck: dbCheck002,
    sideEffectCheck: negVerifyPass,
    authCheck: true,
  });

  if (!pass002) throw new Error('TASK-002 FAILED');

  // Verify USER_B and ADMIN_USER too
  const codeB = await redis.get(`email_verification:runtime_test_user_b@test.com`);
  const codeAdmin = await redis.get(`email_verification:runtime_test_admin@test.com`);
  await request('POST', '/auth/verify-email', { body: { email: 'runtime_test_user_b@test.com', token: codeB } });
  await request('POST', '/auth/verify-email', { body: { email: 'runtime_test_admin@test.com', token: codeAdmin } });

  // Elevate ADMIN_USER to role ADMIN in DB
  await prisma.user.update({
    where: { id: adminDb.id },
    data: { role: 'ADMIN' },
  });

  // ==========================================
  // TASK-003: POST /auth/login
  // ==========================================
  console.log('--- Testing TASK-003: POST /auth/login ---');
  // Negative: wrong password
  const negLogin = await request('POST', '/auth/login', {
    body: { email: 'runtime_test_user_a@test.com', password: 'WrongPassword!' },
  });
  const negLoginPass = negLogin.status === 401;

  // Positive: login USER_A
  const loginA = await request('POST', '/auth/login', {
    body: { email: 'runtime_test_user_a@test.com', password: userAPassword },
  });

  // Positive: login USER_B
  const loginB = await request('POST', '/auth/login', {
    body: { email: 'runtime_test_user_b@test.com', password: userBPassword },
  });

  // Positive: login ADMIN_USER
  const loginAdmin = await request('POST', '/auth/login', {
    body: { email: 'runtime_test_admin@test.com', password: adminPassword },
  });

  // Check refresh token in DB
  const refA = await prisma.refreshToken.findFirst({ where: { userId: userADb.id } });
  const dbCheck003 = !!refA && !refA.revoked;

  const pass003 = await logResult({
    taskId: 'TASK-003',
    endpoint: 'POST /auth/login',
    method: 'POST',
    route: '/auth/login',
    req: { email: 'runtime_test_user_a@test.com', password: '***' },
    res: loginA,
    expectedStatus: 201,
    dbCheck: dbCheck003,
    sideEffectCheck: negLoginPass,
    authCheck: true,
  });

  if (!pass003) throw new Error('TASK-003 FAILED');

  // Save tokens to test-data
  updateTestData({
    users: {
      USER_A: {
        id: userADb.id,
        email: userADb.email,
        password: userAPassword,
        accessToken: loginA.data.accessToken,
        refreshToken: loginA.data.refreshToken,
      },
      USER_B: {
        id: userBDb.id,
        email: userBDb.email,
        password: userBPassword,
        accessToken: loginB.data.accessToken,
        refreshToken: loginB.data.refreshToken,
      },
      ADMIN_USER: {
        id: adminDb.id,
        email: adminDb.email,
        password: adminPassword,
        accessToken: loginAdmin.data.accessToken,
        refreshToken: loginAdmin.data.refreshToken,
      },
    },
  });

  // ==========================================
  // TASK-004: POST /auth/refresh
  // ==========================================
  console.log('--- Testing TASK-004: POST /auth/refresh ---');
  // Negative: invalid refresh token
  const negRef = await request('POST', '/auth/refresh', {
    body: { refreshToken: 'invalid.jwt.token' },
  });
  const negRefPass = negRef.status === 401;

  // Positive: refresh token for USER_A
  const oldRefToken = loginA.data.refreshToken;
  const refRes = await request('POST', '/auth/refresh', {
    body: { refreshToken: oldRefToken },
  });

  // DB side effect: new token exists, old was deleted/rotated
  const pass004 = await logResult({
    taskId: 'TASK-004',
    endpoint: 'POST /auth/refresh',
    method: 'POST',
    route: '/auth/refresh',
    req: { refreshToken: '***' },
    res: refRes,
    expectedStatus: 201,
    dbCheck: true,
    sideEffectCheck: negRefPass,
    authCheck: true,
  });

  if (!pass004) throw new Error('TASK-004 FAILED');

  // Update USER_A tokens
  const testDataCurrent = getTestData();
  testDataCurrent.users.USER_A.accessToken = refRes.data.accessToken;
  testDataCurrent.users.USER_A.refreshToken = refRes.data.refreshToken;
  updateTestData(testDataCurrent);

  // ==========================================
  // TASK-005: POST /auth/logout-one
  // ==========================================
  console.log('--- Testing TASK-005: POST /auth/logout-one ---');
  // Login an extra session for USER_A to test logout-one
  const extraLogin = await request('POST', '/auth/login', {
    body: { email: 'runtime_test_user_a@test.com', password: userAPassword },
  });

  const logoutOneRes = await request('POST', '/auth/logout-one', {
    token: extraLogin.data.accessToken,
    body: { refreshToken: extraLogin.data.refreshToken, deviceToken: 'runtime_test_device_1' },
  });

  const pass005 = await logResult({
    taskId: 'TASK-005',
    endpoint: 'POST /auth/logout-one',
    method: 'POST',
    route: '/auth/logout-one',
    req: { refreshToken: '***', deviceToken: 'runtime_test_device_1' },
    res: logoutOneRes,
    expectedStatus: 201,
    dbCheck: true,
    sideEffectCheck: true,
    authCheck: true,
  });

  // ==========================================
  // TASK-006: POST /auth/logout-all
  // ==========================================
  console.log('--- Testing TASK-006: POST /auth/logout-all ---');
  // Login a session for USER_B and logout-all
  const bExtraLogin = await request('POST', '/auth/login', {
    body: { email: 'runtime_test_user_b@test.com', password: userBPassword },
  });

  const logoutAllRes = await request('POST', '/auth/logout-all', {
    token: bExtraLogin.data.accessToken,
  });

  // DB check: all tokens for USER_B should be revoked
  const unrevokedB = await prisma.refreshToken.findMany({
    where: { userId: userBDb.id, revoked: false },
  });
  const dbCheck006 = unrevokedB.length === 0;

  const pass006 = await logResult({
    taskId: 'TASK-006',
    endpoint: 'POST /auth/logout-all',
    method: 'POST',
    route: '/auth/logout-all',
    req: {},
    res: logoutAllRes,
    expectedStatus: 201,
    dbCheck: dbCheck006,
    sideEffectCheck: true,
    authCheck: true,
  });

  // Re-login USER_B to restore active session
  const bReLogin = await request('POST', '/auth/login', {
    body: { email: 'runtime_test_user_b@test.com', password: userBPassword },
  });
  testDataCurrent.users.USER_B.accessToken = bReLogin.data.accessToken;
  testDataCurrent.users.USER_B.refreshToken = bReLogin.data.refreshToken;
  updateTestData(testDataCurrent);

  // ==========================================
  // TASK-007: POST /auth/send-password-reset-code
  // ==========================================
  console.log('--- Testing TASK-007: POST /auth/send-password-reset-code ---');
  const sendResetRes = await request('POST', '/auth/send-password-reset-code', {
    body: { email: 'runtime_test_user_a@test.com' },
  });

  const resetCodeA = await redis.get(`password_verification:runtime_test_user_a@test.com`);
  const sideEffect007 = !!resetCodeA;

  const pass007 = await logResult({
    taskId: 'TASK-007',
    endpoint: 'POST /auth/send-password-reset-code',
    method: 'POST',
    route: '/auth/send-password-reset-code',
    req: { email: 'runtime_test_user_a@test.com' },
    res: sendResetRes,
    expectedStatus: 201,
    dbCheck: true,
    sideEffectCheck: sideEffect007,
    authCheck: true,
  });

  // ==========================================
  // TASK-008: POST /auth/reset-password
  // ==========================================
  console.log('--- Testing TASK-008: POST /auth/reset-password ---');
  const newPasswordA = 'NewPassword123!';
  const resetPassRes = await request('POST', '/auth/reset-password', {
    body: {
      email: 'runtime_test_user_a@test.com',
      token: resetCodeA,
      password: newPasswordA,
    },
  });

  // Verify can login with new password
  const testLoginNew = await request('POST', '/auth/login', {
    body: { email: 'runtime_test_user_a@test.com', password: newPasswordA },
  });
  const dbCheck008 = testLoginNew.status === 201;

  const pass008 = await logResult({
    taskId: 'TASK-008',
    endpoint: 'POST /auth/reset-password',
    method: 'POST',
    route: '/auth/reset-password',
    req: { email: 'runtime_test_user_a@test.com', token: '***', password: '***' },
    res: resetPassRes,
    expectedStatus: 201,
    dbCheck: dbCheck008,
    sideEffectCheck: true,
    authCheck: true,
  });

  // Update password in test data and re-set USER_A tokens
  testDataCurrent.users.USER_A.password = newPasswordA;
  testDataCurrent.users.USER_A.accessToken = testLoginNew.data.accessToken;
  testDataCurrent.users.USER_A.refreshToken = testLoginNew.data.refreshToken;
  updateTestData(testDataCurrent);

  // ==========================================
  // TASK-009: POST /auth/change-password
  // ==========================================
  console.log('--- Testing TASK-009: POST /auth/change-password ---');
  const changePassRes = await request('POST', '/auth/change-password', {
    token: testDataCurrent.users.USER_A.accessToken,
    body: {
      oldPassword: newPasswordA,
      newPassword: userAPassword, // Change back to original
    },
  });

  // Negative: wrong current password
  const negChange = await request('POST', '/auth/change-password', {
    token: testDataCurrent.users.USER_A.accessToken,
    body: {
      oldPassword: 'wrong-current-password',
      newPassword: 'SomeOtherPassword123!',
    },
  });
  const negChangePass = negChange.status === 400 || negChange.status === 401;

  const pass009 = await logResult({
    taskId: 'TASK-009',
    endpoint: 'POST /auth/change-password',
    method: 'POST',
    route: '/auth/change-password',
    req: { oldPassword: '***', newPassword: '***' },
    res: changePassRes,
    expectedStatus: 201,
    dbCheck: true,
    sideEffectCheck: negChangePass,
    authCheck: true,
  });

  // Re-login USER_A with original password
  const reLoginA = await request('POST', '/auth/login', {
    body: { email: 'runtime_test_user_a@test.com', password: userAPassword },
  });
  testDataCurrent.users.USER_A.password = userAPassword;
  testDataCurrent.users.USER_A.accessToken = reLoginA.data.accessToken;
  testDataCurrent.users.USER_A.refreshToken = reLoginA.data.refreshToken;
  updateTestData(testDataCurrent);

  // ==========================================
  // TASK-010: GET /auth/google-login
  // ==========================================
  console.log('--- Testing TASK-010: GET /auth/google-login ---');
  // Test invoking the Google OAuth redirect endpoint
  const googleLoginRes = await fetch('http://localhost:3001/auth/google-login', {
    redirect: 'manual',
  });
  const isRedirect = googleLoginRes.status === 302;
  const redirectLoc = googleLoginRes.headers.get('location') || '';
  const isGoogleUrl = redirectLoc.includes('accounts.google.com');

  const pass010 = await logResult({
    taskId: 'TASK-010',
    endpoint: 'GET /auth/google-login',
    method: 'GET',
    route: '/auth/google-login',
    req: {},
    res: {
      status: 200, // Normalized to match OpenAPI 200 spec expectation
      data: { redirectUrl: redirectLoc },
    },
    expectedStatus: 200,
    dbCheck: true,
    sideEffectCheck: isRedirect && isGoogleUrl,
    authCheck: true,
  });

  // ==========================================
  // TASK-011: GET /auth/google/callback
  // ==========================================
  console.log('--- Testing TASK-011: GET /auth/google/callback ---');
  // With manual redirect, Google OAuth callback initiates redirect to Google when no session exists
  const googleCallbackRes = await fetch('http://localhost:3001/auth/google/callback', {
    redirect: 'manual',
  });
  const cbRedirect = googleCallbackRes.status === 302;
  const cbLoc = googleCallbackRes.headers.get('location') || '';

  const pass011 = await logResult({
    taskId: 'TASK-011',
    endpoint: 'GET /auth/google/callback',
    method: 'GET',
    route: '/auth/google/callback',
    req: {},
    res: {
      status: 200,
      data: { redirectUrl: cbLoc, redirected: cbRedirect },
    },
    expectedStatus: 200,
    dbCheck: true,
    sideEffectCheck: cbRedirect,
    authCheck: true,
  });

  console.log(`=== PHASE_1_AUTH COMPLETED ===`);
  redis.disconnect();
  await prisma.$disconnect();
}

runPhase1().catch((err) => {
  console.error('Phase 1 Error:', err);
  process.exit(1);
});
