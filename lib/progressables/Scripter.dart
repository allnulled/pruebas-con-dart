import 'dart:convert';

class Node {
  String toJson() {
    return "{}";
  }
}

class NumberNode extends Node {
  final num value;
  NumberNode(this.value);
  @override
  String toString() {
    return '${value.toString()}';
  }

  @override
  String toJson() {
    return '{"type":"NumberNode"}';
  }
}

class StringNode extends Node {
  final String value;
  StringNode(this.value);
  @override
  String toString() {
    return '"${value.toString()}"';
  }

  @override
  String toJson() {
    return '{"type":"StringNode"}';
  }
}

class SymbolNode extends Node {
  final String name;
  SymbolNode(this.name);
  @override
  String toString() {
    return "${name.toString()}";
  }

  @override
  String toJson() {
    return '{"type":"SymbolNode"}';
  }
}

class CallNode extends Node {
  final String name;
  final List<Node> args;
  CallNode(this.name, this.args);
  @override
  String toString() {
    return "($name ${args.map((arg) => arg.toString()).join(" ")})";
  }

  @override
  String toJson() {
    return '{"type":"CallNode","content":${args}}';
  }
}

class BlockNode extends Node {
  final List<Node> body;
  BlockNode(this.body);
  @override
  String toString() {
    return "[${body.join(" ")}]";
  }

  @override
  String toJson() {
    return '{"type":"BlockNode"}';
  }
}

class Parser {
  static List<String> tokenize(String input) {
    // La lista de tokens que queremos devolver
    List<String> tokens = [];
    // El buffer es donde se va guardando el string
    String buffer = "";
    // Flag para saber si estamos en un string o no
    bool inString = false;
    // Flag para saber si estamos en un comentario o no
    bool inComment = false;
    // Iteras el string char x char:
    Iterating_input:
    for (int i = 0; i < input.length; i++) {
      // Aislas el char:
      String c = input[i];
      // Si estás en comentarios y cierras comentario, volver a no comentario y avanzar 2 casillas
      By_carl_para_soportar_comentarios_1:
      {
        if (inComment) {
          if ((c == "*") && (input[i + 1] == "/")) {
            inComment = false;
            i++;
          }
          continue Iterating_input;
        }
      }
      // Si estás en string:
      // Es el primero porque es una acepto-caracter sin muchas más condiciones
      // También porque tiene prioridad sobre otras condiciones
      if (inString) {
        // Si ya se acaba el string:
        if (c == '"') {
          // apendizar buffer + limpiar buffer + resetear estado inString a false + saltar al siguiente caracter
          tokens.add('"$buffer"');
          buffer = "";
          inString = false;
          continue Iterating_input;
        }
        // Si aún no se ha acabado el string, caracter para el buffer + saltar al siguiente caracter
        buffer += c;
        continue Iterating_input;
      }
      // Si no estás en string pero te encuentras un doble-comitas:
      if (c == '"') {
        // entrar a inString + saltar al siguiente caracter
        inString = true;
        continue Iterating_input;
      }
      // Si no estás ni en comentarios ni en string y encuentras cerrar comentario, entrar en modo comentario + avanzar 2 casillas + saltar al siguiente
      By_carl_para_soportar_comentarios_2:
      {
        if ((c == "/") && (input[i + 1] == "*")) {
          inComment = true;
          i++;
          continue Iterating_input;
        }
      }
      // Si no estás en string, ni te encuentras con doble-comitas, pero te encuentras con ( o ) o [ o ]:
      if (c == '(' || c == ')' || c == '[' || c == ']') {
        // Si el buffer tiene algo dentro - porque ya sobreentiende que es [ o ( supongo
        if (buffer.length > 0) {
          // Añade el buffer al tokens + limpiar buffer + dejar seguir
          tokens.add(buffer);
          buffer = "";
        }
        // Añade el caracter al tokens (este caracter solo informa que ahí se abre o cierra)
        tokens.add(c);
        continue Iterating_input;
      }
      // Si no estás en string, ni te encuentras caracteres especiales, pero el caracter sin espacios no tiene longitud (caso de espacio):
      if (c.trim().length == 0) {
        // Si hay algo en el buffer
        if (buffer.length > 0) {
          // Añade el buffer al tokens + limpiar buffer + dejar pasar
          tokens.add(buffer);
          buffer = "";
        }
        // saltar a siguiente caracter
        continue Iterating_input;
      }
      // Si no estás en string, ni te encuentras caracteres especiales, ni el caracter que te encuentras está vacío (caso de escribir en el buffer):
      buffer += c;
    }
    // Si al acabar el loop hay algo en el buffer
    if (buffer.length > 0) {
      // Añadir buffer al tokens
      tokens.add(buffer);
    }
    // Retornar tokens
    return tokens;
  }

  late List<String> tokens;

  int pos = 0;

  Parser(String input) {
    tokens = tokenize(input);
  }

  String peek() {
    return tokens[pos];
  }

  String next() {
    return tokens[pos++];
  }

  Node parseTokens() {
    // Si el token es un abrir paréntesis:
    if (peek() == '(') {
      // avanzar el token iterado
      next();
      // avanzar el token iterado + sacar su valor
      String name = next();
      // iniciar lista de args
      List<Node> args = [];
      // hasta que no encuentre cerrar paréntesis:
      while (peek() != ')') {
        // recursivamente parsear tokens y sacar el resultado
        Node node = parseTokens();
        // añadir el contenido en args
        args.add(node);
      }
      // avanzar el token iterado
      next();
      // devolver un nodo tipo llamada con el nombre y los argumentos
      return CallNode(name, args);
    }
    // Si el token es un abrir square-brackets
    if (peek() == '[') {
      // avanzar el token iterado
      next();
      // iniciar lista de body
      List<Node> body = [];
      // hasta que no encuentre cerrar square-brackets
      while (peek() != ']') {
        // recursivamente parsear tokens y sacar el resultado
        Node node = parseTokens();
        // añádir el contenido en body
        body.add(node);
      }
      // avanzar el token iterado
      next();
      // devolver un nodo tipo bloque con los arguments
      return BlockNode(body);
    }
    // Si el token no es un abrir paréntesis ni abrir square-brackets, avanzar el token + sacar su valor
    String token = next();
    // Si el token empieza por doble-comitas
    if (token.startsWith('"') && token.endsWith('"')) {
      // aislar el contenido del string
      String content = token.substring(1, token.length - 1);
      // devolver un nodo con los argumentos
      return StringNode(content);
    }
    // Si el token no empieza por doble-comitas, intentar parsearlo como número
    num? number = num.tryParse(token);
    // Si es un número
    if (number != null) {
      // devolver un nodo tipo número con los argumentos
      return NumberNode(number);
    }
    // Si no es abrir paréntesis, ni bloque, ni string, ni número, es un símbol, así que
    // devolver un nodo tipo simbolo
    return SymbolNode(token);
  }

  List<Node> parseProgram({bool unflatten = false}) {
    List<Node> nodes = [];
    while (pos < tokens.length) {
      nodes.add(parseTokens());
    }
    if (unflatten) {
      return nodes;
    }
    Parser.flattenAst(nodes);
    return nodes;
  }

  static void flattenAst(List<Node> originalAst) {
    int tmpCounter = 0;

    String nextTmp() => "@tmp${++tmpCounter}";

    Node process(Node node, List<Node> out, {bool insideCall = false}) {
      if (node is BlockNode) {
        return node;
      }

      if (node is CallNode) {
        List<Node> newArgs = [];

        for (var arg in node.args) {
          Node processed = process(arg, out, insideCall: true);
          newArgs.add(processed);
        }

        CallNode newCall = CallNode(node.name, newArgs);

        // 🔥 si estamos dentro de otro Call → tmp
        if (insideCall) {
          String tmpName = nextTmp();

          out.add(
            CallNode("set", [SymbolNode(tmpName), SymbolNode("="), newCall]),
          );

          return SymbolNode(tmpName);
        }

        // 🌱 root → devolver versión transformada
        return newCall;
      }

      return node;
    }

    List<Node> result = [];

    for (var node in originalAst) {
      Node processed = process(node, result, insideCall: false);
      result.add(processed);
    }

    // Reemplazar contenido original
    originalAst
      ..clear()
      ..addAll(result);
  }
}

class Vocabulary {
  static const Map<String, dynamic> defaultCallbacks = {};

  final Map<String, dynamic> callbacks = {
    "set": (List args, Map localMemory, Map callbacks) { return "set"; },
    "substract": (List args, Map localMemory, Map callbacks) { return "substract"; },
    "multiply": (List args, Map localMemory, Map callbacks) { return "multiply"; },
    "divide": (List args, Map localMemory, Map callbacks) { return "divide"; },
    "sum": (List args, Map localMemory, Map callbacks) { return "sum"; },
    "math.random.uid": (List args, Map localMemory, Map callbacks) { return "math.random.uid"; },
    "power": (List args, Map localMemory, Map callbacks) { return "power"; },
    "local": (List args, Map localMemory, Map callbacks) { return "local"; },
    "parameters": (List args, Map localMemory, Map callbacks) { return "parameters"; },
    "print": (List args, Map localMemory, Map callbacks) { return "print"; },
    "string": (List args, Map localMemory, Map callbacks) { return "string"; },
    "io.print": (List args, Map localMemory, Map callbacks) { return "io.print"; },
    "call": (List args, Map localMemory, Map callbacks) { return "call"; },
    "add": (List args, Map localMemory, Map callbacks) { return "add"; },
    "local.get": (List args, Map localMemory, Map callbacks) { return "local.get"; },
    "local.set": (List args, Map localMemory, Map callbacks) { return "local.set"; },
    "class": (List args, Map localMemory, Map callbacks) { return "class"; },
    "extends": (List args, Map localMemory, Map callbacks) { return "extends"; },
    "implements": (List args, Map localMemory, Map callbacks) { return "implements"; },
    "static.property": (List args, Map localMemory, Map callbacks) { return "static.property"; },
    "static": (List args, Map localMemory, Map callbacks) { return "static"; },
    "property": (List args, Map localMemory, Map callbacks) { return "property"; },
    "math": (List args, Map localMemory, Map callbacks) { return "math"; },
    "method": (List args, Map localMemory, Map callbacks) { return "method"; },
    "return": (List args, Map localMemory, Map callbacks) { return "return"; },
  };

  Vocabulary({Map<String, dynamic> callbacks = Vocabulary.defaultCallbacks});

  static final Vocabulary global = Vocabulary();
}

class Scripter {
  static List<Node> ast(String input) {
    Parser p = Parser(input);
    List<Node> ast = p.parseProgram(unflatten: false);
    return ast;
  }

  static dynamic evaluate(String input, {Map localMemory = const {}}) {
    List<Node> ast = Scripter.ast(input);
    /*
      NumberNode > .value
      StringNode > .value
      SymbolNode > .name
      CallNode > .name
      CallNode > .args
      BlockNode > .body
    */
    return Scripter.innerEvaluate(ast);
  }

  static dynamic innerEvaluate(List<Node> ast, {Map localMemory = const {}}) {
    dynamic lastEvaluation = [];
    List allEvaluations = [];
    for (int i = 0; i < ast.length; i++) {
      Node node = ast[i];
      print(node);
      if (node is NumberNode) {
        lastEvaluation = node.value;
      } else if (node is StringNode) {
        lastEvaluation = node.value;
      } else if (node is SymbolNode) {
        lastEvaluation = node.name;
      } else if (node is CallNode) {
        dynamic evaluatedArgs = Scripter.innerEvaluate(node.args);
        lastEvaluation = Scripter.callback(
          node,
          localMemory: localMemory,
          evaluatedArgs: evaluatedArgs,
        );
      } else if (node is BlockNode) {
        lastEvaluation = () {
          return Scripter.evaluate(node.body.toString());
        };
      } else {
        throw Exception("Ast node type is not identified $node");
      }
      allEvaluations.add(lastEvaluation);
    }
    return allEvaluations;
  }

  static dynamic callback(
    CallNode node, {
    Map localMemory = const {},
    Vocabulary? vocabularyInput,
    List evaluatedArgs = const [],
  }) {
    String idCall = node.name;
    List<Node> argsCall = node.args;
    Vocabulary vocabulary = vocabularyInput ?? Vocabulary.global;
    bool knowsCallback = vocabulary.callbacks.containsKey(idCall);
    if (!knowsCallback) {
      throw Exception(
        "Directive «$idCall» is not defined on vocabulary on «Scripter.callback»",
      );
    }
    Function callback = vocabulary.callbacks[idCall];
    return Function.apply(callback, [
      argsCall,
      localMemory,
      vocabulary.callbacks,
    ]);
  }
}

void main() {
  dynamic output1 = Scripter.evaluate("""
      /* Ahora le puedo poner comentarios y no pasa nada? */
      (sum (substract 200 100) (multiply 25 4) (divide 25 5) (power 2 3))
      (local.set sayHello = [
        (parameters name age city)
        (print name age city)
        (return (string.concat "Hi, " name "!"))
      ])
      (io.print "Hello" "How are you" "This is a new line")
      (io.print (call sayHello "Carl" (add 35 28) "Oklahome"))
      (local.set Name = (class anonymous
        (extends @Whatever @Whatever2 @Whatever300)
        (implements @Whatever5 @WhateverBB)
        (static.property name = "Name")
        (static.property version = "1.0.0")
        (property uid = (math.random.uid 20))
        (method getVersion = [
          (parameters)
          (return (math.random.uid 20))
        ])
      ))

      (return message)
    """);

  print(output1);
  if (output1 is List) {
    print(output1.join("\n"));
  }

  return;

  for (int index = 0; index < output1.length; index++) {
    dynamic item = output1[index];
    print(item);
  }
}


/*

Pues ahora mismo estoy aquí, me devuelve:

[(set @tmp1 = (substract 200 100)), (set @tmp2 = (multiply 25 4)), (set @tmp3 = (divide 25 5)), (set @tmp4 = (power 2 3)), (sum (substract 200 100) (multiply 25 4) (divide 25 5) (power 2 3)), (local.set sayHello = [(parameters name age city) (print name age city) (return (string.concat "Hi, " name "!"))]), (io.print "Hello" "How are you" "This is a new line"), (set @tmp5 = (add 35 28)), (set @tmp6 = (call sayHello "Carl" @tmp5 "Oklahome")), (io.print (call sayHello "Carl" (add 35 28) "Oklahome")), (set @tmp7 = (extends @Whatever @Whatever2 @Whatever300)), (set @tmp8 = (implements @Whatever5 @WhateverBB)), (set @tmp9 = (static.property name = "Name")), (set @tmp10 = (static.property version = "1.0.0")), (set @tmp11 = (math.random.uid 20)), (set @tmp12 = (property uid = @tmp11)), (set @tmp13 = (method getVersion = [(parameters ) (return (math.random.uid 20))])), (set @tmp14 = (class anonymous @tmp7 @tmp8 @tmp9 @tmp10 @tmp12 @tmp13)), (local.set Name = (class anonymous (extends @Whatever @Whatever2 @Whatever300) (implements @Whatever5 @WhateverBB) (static.property name = "Name") (static.property version = "1.0.0") (property uid = (math.random.uid 20)) (method getVersion = [(parameters ) (return (math.random.uid 20))]))), (return message)]
(set @tmp1 = (substract 200 100))
(set @tmp2 = (multiply 25 4))
(set @tmp3 = (divide 25 5))
(set @tmp4 = (power 2 3))
(sum (substract 200 100) (multiply 25 4) (divide 25 5) (power 2 3))
(local.set sayHello = [(parameters name age city) (print name age city) (return (string.concat "Hi, " name "!"))])
(io.print "Hello" "How are you" "This is a new line")
(set @tmp5 = (add 35 28))
(set @tmp6 = (call sayHello "Carl" @tmp5 "Oklahome"))
(io.print (call sayHello "Carl" (add 35 28) "Oklahome"))
(set @tmp7 = (extends @Whatever @Whatever2 @Whatever300))
(set @tmp8 = (implements @Whatever5 @WhateverBB))
(set @tmp9 = (static.property name = "Name"))
(set @tmp10 = (static.property version = "1.0.0"))
(set @tmp11 = (math.random.uid 20))
(set @tmp12 = (property uid = @tmp11))
(set @tmp13 = (method getVersion = [(parameters ) (return (math.random.uid 20))]))
(set @tmp14 = (class anonymous @tmp7 @tmp8 @tmp9 @tmp10 @tmp12 @tmp13))
(local.set Name = (class anonymous (extends @Whatever @Whatever2 @Whatever300) (implements @Whatever5 @WhateverBB) (static.property name = "Name") (static.property version = "1.0.0") (property uid = (math.random.uid 20)) (method getVersion = [(parameters ) (return (math.random.uid 20))])))
(return message)

Estoy intentando ajustar los niveles de profundidad del flateneo.

Pero hace una cosa muy rara:

(set @tmp5 = (add 35 28))
(set @tmp6 = (call sayHello "Carl" @tmp5 "Oklahome"))

Estos están bien, pero en cambio estos:

(io.print (call sayHello "Carl" (add 35 28) "Oklahome"))
(sum (substract 200 100) (multiply 25 4) (divide 25 5) (power 2 3))

Estos no, porque estarían mostrando más profundidad de la que intento.

Cómo lo acabarías de ajustar todo esto?

*/