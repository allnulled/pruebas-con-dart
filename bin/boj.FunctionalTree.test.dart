#!/usr/bin/env dart

import './dist/FunctionalTree.dart';

void main(List<String> args) {
  test();
}

dynamic boj = FunctionalTree({
  "version": "1.0.0",
  "gui": {
    "start": () {
      print("boj.gui.start");
    },
  },
  "cli": {
    "mask": {},
    "whatever": (dynamic a, dynamic b) {
      print("boj.cli.whatever");
      print(a + b);
      return a + b;
    },
  },
});

void test() {
  // Funcionaría sin el hack noSuchMethod:
  boj["gui"]["start"]();
  boj["cli"]["whatever"](5, 10);
  // Funciona, pero no funcionaría sin el hack noSuchMethod:
  boj.gui.start();
  boj.cli.whatever(5, 16);
  // Get:
  dynamic w1 = boj.get(["cli", "whatever"]);
  if (w1 is! Function) {
    throw Exception("var cli.whatever should be a function");
  }
  // Set:
  boj.set(["cli", "whatever"], 900);
  if (boj.cli.whatever != 900) {
    throw Exception("var cli.whatever should be 900");
  }
  // Init:
  boj.init(["cli", "whatever"], 899);
  if (boj.cli.whatever != 900) {
    throw Exception("var cli.whatever should still be 900");
  }
  // Delete:
  boj.delete(["cli", "whatever"]);
  // Has:
  bool stillExists = boj.has(["cli", "whatever"]);
  if (stillExists) {
    throw Exception("var cli.whatever should not exist");
  }
  // List:
  dynamic w2 = boj.list(["cli"]);
  if(w2[0] != "mask") {
    throw Exception("var cli should have mask as first and unique key");
  }
  print(w2);

}
