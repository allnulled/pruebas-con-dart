const fs = require("fs");
const path = require("path");
const os = require("os");
const marked = require("marked");
const child_process = require("child_process");
const glob = require("fast-glob");
const { extractToc, RegexFor } = require(__dirname + "/build.utils.js");

const SETTINGS = {
  IGNORE_COMPILATION: 1,
};

const trace = (...args) => {
  console.log("[trace]", ...args);
};

const exec = (cmd) => new Promise((ok, err) => {
  child_process.exec(cmd, (e, stdout, stderr) => {
    if (e) return err(stderr || stdout || e);
    ok(stdout);
  });
});

const compileDart = async function (dartCode) {
  const tmp = await fs.promises.mkdtemp(path.join(os.tmpdir(), "dart-md-"));
  const dartFile = path.join(tmp, "snippet.dart");
  const jsFile = path.join(tmp, "snippet.js");
  const wasmFile = path.join(tmp, "snippet.wasm");
  await fs.promises.writeFile(dartFile, dartCode, "utf8");
  try {
    await exec(`dart compile js -O4 "${dartFile}" -o "${jsFile}"`);
  } catch (e) {
    console.error(e);
    throw e;
  }
  try {
    await exec(`dart compile wasm "${dartFile}" -o "${wasmFile}"`);
  } catch (e) {
    console.error(e);
    throw e;
  }
  let js = "";
  let wasm = "";
  if (fs.existsSync(jsFile)) {
    js = await fs.promises.readFile(jsFile, "utf8");
  }
  if (fs.existsSync(wasmFile)) {
    wasm = await fs.promises.readFile(wasmFile, "utf8");
  }
  return { js, wasm };
};

const main = async function () {
  const basedir = __dirname;
  const mdsUnsorted = await glob(`${basedir}/**/TUTORIAL.md`);
  const mds = mdsUnsorted.sort();
  let content = "";
  for (const md of mds) {
    const mdRelative = md.replace(basedir + "/", "").replace(/\/TUTORIAL.md$/g, "");
    trace(`Processing file: ${mdRelative}`);
    const subcontent = await fs.promises.readFile(md, "utf8");
    content += `# ${mdRelative.replace(RegexFor.initialNumbers, "")}\n\n${subcontent}\n\n`;
  }
  Compile_examples_to_ensure_they_are_ok:
  if (!SETTINGS.IGNORE_COMPILATION) {
    trace("Checking for errors in compilation-time");
    const tokens = marked.lexer(content);
    const newTokens = [];
    let counter = 0;
    for (const token of tokens) {
      counter++;
      process.stdout.write(`[trace] Processing token ${counter}/${tokens.length}\r`);
      newTokens.push(token);
      if (token.type === "code" && token.lang === "dart") {
        const { js, wasm } = await compileDart(token.text);
        if (js) {
          // newTokens.push(...marked.lexer(`\n\nLo cual en JS se vería así:\n\n\`\`\`js\n${js}\n\`\`\`\n\n`));
        }
        if (wasm) {

        }
      }
    }
    const finalHtml = marked.parser(newTokens);
    const outputFile2 = `${basedir}/DART.marked.html`;
    await fs.promises.writeFile(outputFile2, finalHtml, "utf8");
  }
  trace("Unifying into 1 source code");
  const outputFile = `${basedir}/DART.md`;
  const toc = extractToc(content);
  const finalContent = toc + "\n\n" + content;
  await fs.promises.writeFile(outputFile, finalContent, "utf8");
  trace("Done!");

};

main();