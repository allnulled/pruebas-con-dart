#!/usr/bin/env dart

void main(List<String> args) {
  Map argc = compileCommandLineArguments(args);
  print(argc);
}

Map compileCommandLineArguments(List<String> args) {
  Map argc = {};
  List positional = [];
  argc["_"] = positional;
  int i = 0;
  while (i < args.length) {
    String arg = args[i];
    bool isFlag = arg.startsWith("--");
    if (isFlag == false) {
      positional.add(arg);
      i = i + 1;
      continue;
    }
    String key = arg.substring(2);
    int j = i + 1;
    List values = [];
    while (j < args.length) {
      String next = args[j];
      bool nextIsFlag = next.startsWith("--");
      if (nextIsFlag) {
        break;
      }
      values.add(next);
      j = j + 1;
    }
    if (values.isEmpty) {
      argc[key] = true;
    } else if (values.length == 1) {
      String v = values[0];
      int? asInt = int.tryParse(v);
      double? asDouble = double.tryParse(v);
      if (asInt != null) {
        argc[key] = asInt;
      } else if (asDouble != null) {
        argc[key] = asDouble;
      } else {
        argc[key] = v;
      }
    } else {
      argc[key] = values;
    }
    i = j;
  }
  return argc;
}