const fs = require("fs");
const { extractToc } = require(__dirname + "/build.utils.js");

const json = fs.readFileSync(__dirname + "-dart.compilation.json").toString();
const data = JSON.parse(json);

let globalCounter = 0;

const escapeHtml = function(md) {
  return md.replace(/\</g, "&lt;").replace(/\>/g, "&gt;");
}

const generateDoc = function(part, info) {
  let out1 = "";
  let out2 = "";
  out1 += `# ${escapeHtml(info.name)}\n\n`;
  out1 += `Estás en el nodo ${info.counter} de ${info.total} [${Math.round((info.counter/info.total)*100)}%]\n\n`;
  out1 += `## Índice de ${escapeHtml(info.name)}\n\n`;
  out1 += "- Estructura de la documentación:\n";
  let pad = -1;
  const getPad = function() {
    return "   ".repeat(pad);
  };
  const sections = Object.keys(part);
  for(let indexSection=0; indexSection<sections.length; indexSection++) {
    const sectionId = sections[indexSection] || "(none)";
    const items = part[sectionId];
    pad++;
    for(let indexItem=0; indexItem<items.length; indexItem++) {
      pad++;
      const item = items[indexItem];
      const { title, description } = item;
      const globalId = globalCounter++;
      out1 += `${getPad()}- ${info.counter}.${indexSection}.${indexItem}. ${escapeHtml(info.name)} » ${escapeHtml(sectionId)} » ${escapeHtml(title)} @${globalId}\n`;
      out2 += `### ${info.counter}.${indexSection}.${indexItem}. ${escapeHtml(info.name)} » ${escapeHtml(sectionId)} » ${escapeHtml(title)} @${globalId}\n\n`;
      out2 += `> ${escapeHtml(description)}\n\n`;
      pad--;
    }
    pad--;
  }
  out1 += ``;
  return out1 + out2;
};

const urls = Object.keys(data);
let counter = 1;

let all = "";

for(let indexUrl=0; indexUrl<urls.length; indexUrl++) {
  const url = urls[indexUrl];
  const name = url.replace("https://api.flutter.dev/flutter/", "").replace(/\/$/g, "").replace(/\//g, "--") || "none";
  const file = `${__dirname}/${(""+counter++).padStart(4, '0')}. ${name}.md`;
  const part = data[url];
  const content = generateDoc(part, { url, name, file, counter: indexUrl, total: urls.length });
  fs.writeFileSync(file, content, "utf8");
  all += "\n\n" + content;
}

function buildMarkdown(lines) {
  const root = {};

  // Construir árbol
  for (const line of lines) {
    const parts = line.split("»").map(x => x.trim().replace(/\[|\]/g, ""));
    let current = root;
    for (const part of parts) {
      if (!current[part]) current[part] = {};
      current = current[part];
    }
  }

  // Convertir árbol a markdown
  function toMarkdown(node, indent = 0) {
    let md = "";
    for (const key of Object.keys(node)) {
      md += "  ".repeat(indent) + "- " + key + "\n";
      md += toMarkdown(node[key], indent + 1);
    }
    return md;
  }

  return toMarkdown(root);
}

const toc = extractToc(all);

const pretoc = buildMarkdown(toc.split("\n"));

const finalContent = pretoc + "\n\n" + toc + "\n\n" + all;

fs.writeFileSync(`${__dirname}/all-in-one.md`, finalContent, "utf8");