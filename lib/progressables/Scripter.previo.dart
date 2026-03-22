class Node {}

class NumberNode extends Node {
  final num value;
  NumberNode(this.value);
}

class SymbolNode extends Node {
  final String name;
  SymbolNode(this.name);
}

class CallNode extends Node {
  final String name;
  final List<Node> args;

  CallNode(this.name, this.args);
}

class StringNode extends Node {
  final String value;
  StringNode(this.value);
}

class BlockNode extends Node {
  final List<Node> body;
  BlockNode(this.body);
}

class InnerParser {
  late List<String> tokens;
  int pos = 0;
  InnerParser(String input) {
    tokens = InnerParser.tokenize(input);
  }
  static List<String> tokenize(String input) {
    final tokens = <String>[];
    final buffer = StringBuffer();
    bool inString = false;
    bool escape = false;
    for (int i = 0; i < input.length; i++) {
      final char = input[i];
      if (inString) {
        if (escape) {
          buffer.write(char);
          escape = false;
          continue;
        }
        if (char == '\\') {
          escape = true;
          continue;
        }
        if (char == '"') {
          // cerrar string
          tokens.add('"${buffer.toString()}"'); // 👈 conservar comillas
          buffer.clear();
          inString = false;
          continue;
        }
        buffer.write(char);
        continue;
      }
      // fuera de string
      if (char == '"') {
        inString = true;
        continue;
      }
      if (char == '(' || char == ')' || char == '[' || char == ']') {
        if (buffer.isNotEmpty) {
          tokens.add(buffer.toString());
          buffer.clear();
        }
        tokens.add(char);
        continue;
      }
      if (char.trim().isEmpty) {
        if (buffer.isNotEmpty) {
          // Stringificar cuando son strings:
          tokens.add(buffer.toString());
          buffer.clear();
        }
        continue;
      }
      buffer.write(char);
    }
    if (buffer.isNotEmpty) {
      tokens.add(buffer.toString());
    }
    return tokens;
  }
  String peek() => tokens[pos];
  String next() => tokens[pos++];
  Node parseSentence() {
    // Bloque de función
    if (peek() == '[') {
      next();
      final body = <Node>[];
      while (peek() != ']') {
        Node node = parseSentence();
        body.add(node);
      }
      next();
      return BlockNode(body);
    }
    // Bloque de evaluación
    if (peek() == '(') {
      next();
      final name = next();
      final args = <Node>[];
      while (peek() != ')') {
        Node node = parseSentence();
        args.add(node);
      }
      next();
      return CallNode(name, args);
    }
    final token = next();
    // string literal
    if (token.startsWith('"') && token.endsWith('"')) {
      final content = token.substring(1, token.length - 1);
      return StringNode(content);
    }
    // número
    final number = num.tryParse(token);
    if (number != null) return NumberNode(number);
    // símbolo
    return SymbolNode(token);
  }

  List<Node> parseProgram() {
    final nodes = <Node>[];
    while (pos < tokens.length) {
      Node node = parseSentence();
      nodes.add(node);
    }
    return nodes;
  }

}

class InnerFlattener {
  int tempIndex = 0;
  final List<String> instructions = [];
  String flatten(Node node, {bool isRoot = false}) {
    if (node is NumberNode) {
      return node.value.toString();
    }
    if (node is StringNode) {
      return '"${node.value.replaceAll('"', '\\"')}"';
    }
    if (node is SymbolNode) {
      return node.name; // 👈 SIN comillas
    }
    if (node is BlockNode) {
      List<String> parts = [];
      for (int i = 0; i < node.body.length; i++) {
        String sentence = flatten(node.body[i], isRoot: true);
        parts.add("($sentence)");
      }
      return "[ ${parts.join(" ")} ]";
    }
    if (node is CallNode) {
      List args = [];
      for( int i=0; i<node.args.length; i++) {
        String sentence = flatten(node.args[i]);
        args.add(sentence);
      }
      final expr = "${node.name} ${args.join(' ')}";
      if (isRoot) {
        return expr;
      }
      final temp = "@${tempIndex++}";
      instructions.add("local.set $temp = ($expr)");
      return temp;
    }
    throw Exception("Nodo desconocido");
  }
}

class SimpleParser {
  static List parse(String input) {
    final parser = InnerParser(input);
    final program = parser.parseProgram();
    final flattener = InnerFlattener();
    List output = [];
    for (var node in program) {
      final result = flattener.flatten(node, isRoot: true);
      for (var instr in flattener.instructions) {
        output.add(instr);
      }
      output.add(result);
      flattener.instructions.clear(); // 👈 importante
    }
    return output;
  }
}

final Map<String, Function> functions = {
  "local.set": (List args, Map localMemory) {
    print(args);
  },
  "local.get": (List args, Map localMemory) {
    print(args);
  },
  "io.print": (List args, Map localMemory) {
    for(int i = 0; i<args.length; i++) {
      print(args[i]);
    }
  },
  "return": (List args, Map localMemory) {
    print(args);
  },
};

class FunctionNotFoundException implements Exception {
  final String message;
  const FunctionNotFoundException([this.message = ""]);
  String toString() => "FunctionNotFoundException: $message";
}

class Scripter {
  static dynamic eval(String input) {
    Map localMemory = {};
    List output = SimpleParser.parse(input);
    dynamic lastEvaluation;
    for (int i = 0; i < output.length; i++) {
      dynamic sentence = output[i];
      print("[debug][sent:$i] $sentence");
      Map compilation = compile(sentence);
      dynamic id = compilation["call"];
      if (!functions.containsKey(id)) {
        throw FunctionNotFoundException(
          "Native function not found by id «$id» on «Scripter.eval»",
        );
      }
      dynamic callback = functions[id];
      dynamic result = callback(compilation["args"], localMemory);
      lastEvaluation = result;
    }
    return lastEvaluation;
  }

  static Map compile(String sentence) {
    // @TODO:
    List<String> ast = InnerParser.tokenize(sentence);
    return {
      "call": ast[0],
      "args": ast.sublist(1),
    };
  }
}
