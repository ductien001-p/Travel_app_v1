# UI E2E (integration_test)

Live end-to-end flows against a running Travel API: **login → place / trip / profile**.

## Prerequisites

1. Backend reachable from the device/emulator (`API_BASE_URL` / `SOCKET_URL`).
   - Android emulator → host machine: `http://10.0.2.2:3001`
   - iOS simulator / desktop → `http://localhost:3001`
2. Seeded user credentials in `integration_test/e2e.json` (copy from `e2e.example.json`).
3. Featured / catalog places exist for the place flow (approved places in DB).

```bash
cp integration_test/e2e.example.json integration_test/e2e.json
# edit E2E_EMAIL, E2E_PASSWORD, API_BASE_URL
```

Do **not** commit `e2e.json` with real passwords.

## Run

### Preferred (device / emulator)

```bash
# Smoke (login + three tabs)
flutter test integration_test/app_smoke_test.dart \
  --dart-define-from-file=integration_test/e2e.json \
  -d <deviceId>

# Individual flows
flutter test integration_test/flows/place_flow_test.dart \
  --dart-define-from-file=integration_test/e2e.json -d <deviceId>

flutter test integration_test/flows/trip_flow_test.dart \
  --dart-define-from-file=integration_test/e2e.json -d <deviceId>

flutter test integration_test/flows/profile_flow_test.dart \
  --dart-define-from-file=integration_test/e2e.json -d <deviceId>

flutter test integration_test/flows/inbox_flow_test.dart \
  --dart-define-from-file=integration_test/e2e.json -d <deviceId>
```

### Driver (optional)

```bash
flutter drive \
  --driver=test_driver/integration_test.dart \
  --target=integration_test/app_smoke_test.dart \
  --dart-define-from-file=integration_test/e2e.json \
  -d <deviceId>
```

Without `E2E_EMAIL` / `E2E_PASSWORD`, suites throw a clear skip-style error instead of hanging on login.

## What is covered

| Suite | Flow |
|-------|------|
| `app_smoke_test.dart` | Login → Places segment → Trips → Profile |
| `flows/place_flow_test.dart` | Places → featured card → place detail |
| `flows/trip_flow_test.dart` | Trips list + create-trip step 1 (list FAB + center FAB) |
| `flows/profile_flow_test.dart` | Profile → edit → saved tab → saved places screen |
| `flows/inbox_flow_test.dart` | Explore bell → notification inbox |

## Design notes

- Stable selectors live in `lib/core/testing/e2e_keys.dart`.
- Harness mutes deep links and FCM device-token registration so flaky plugins do not fail API/UI assertions.
- Firebase still initializes (same as production `main.dart`).
- Full create-trip finalize / expense settle are intentionally out of scope for v1 (too many media/GPS dependencies).

## Next extensions

- Seed script on backend for deterministic place + trip fixtures.
- Add `E2E_PLACE_ID` dart-define to deep-link into a known place when featured is empty.
- CI job on Android emulator with secret credentials + ephemeral API.
