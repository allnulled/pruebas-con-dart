const marked = require("marked");

const RegexFor = {
  initialNumbers: /^([0-9]+\.)+/g
};

const buildToc = function (markdown) {
  const tokens = marked.lexer(markdown);
  const toc = tokens
    .filter(token => token.type === "heading")
    .map(token => ({
      level: token.depth-1,
      text: token.text,
      id: slugify(token.text)
    }));
  return toc;
};

const slugify = function (text) {
  return text
    .toLowerCase()
    .trim()
    .replace(/[^\w\u00C0-\u024f -]/g, "")
    .replace(/\s+/g, "-")
    .replace(/-+/g, "-");
};

const extractToc = function (markdown) {
  const tree = buildToc(markdown);
  const decompose = function(tree) {
    let out = "";
    out += "# Dart cheat sheet by allnulled\n\n";
    out += "Chuleta para el lenguaje de Dart.\n\n";
    out += "# Índice del documento\n\n";
    for (const node of tree) {
      const indent = "   ".repeat(node.level);
      out += `${indent} - [${node.text.replace(RegexFor.initialNumbers, "")}](#${node.id})\n`;
      if (node.children && node.children.length) {
        out += decompose(node.children);
      }
    }
    return out;
  };
  return decompose(tree);
};

module.exports = { buildToc, extractToc, slugify, RegexFor };