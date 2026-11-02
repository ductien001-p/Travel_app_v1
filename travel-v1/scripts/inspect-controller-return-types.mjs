import ts from 'typescript';

const configFile = ts.readConfigFile('tsconfig.json', ts.sys.readFile);
const config = ts.parseJsonConfigFileContent(configFile.config, ts.sys, '.');
const program = ts.createProgram(config.fileNames, config.options);
const checker = program.getTypeChecker();

for (const source of program.getSourceFiles()) {
  if (!source.fileName.endsWith('.controller.ts')) continue;
  ts.forEachChild(source, (node) => {
    if (!ts.isClassDeclaration(node) || !node.name) return;
    for (const member of node.members) {
      if (!ts.isMethodDeclaration(member) || !member.name) continue;
      const signature = checker.getSignatureFromDeclaration(member);
      if (!signature) continue;
      const type = checker.getReturnTypeOfSignature(signature);
      console.log(
        `${node.name.text}.${member.name.getText(source)}\t${checker.typeToString(type, member, ts.TypeFormatFlags.NoTruncation | ts.TypeFormatFlags.InTypeAlias)}`,
      );
    }
  });
}
