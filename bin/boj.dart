#!/usr/bin/env dart

import "../lib/usables/Platformer.dart";
import "../lib/usables/FunctionalTree.dart";
import "../lib/usables/Inspector.dart";
import "../lib/usables/commands/Environmentable.dart";
import "boj.FunctionalTree.test.dart";
import 'package:flutter_js/flutter_js.dart';

void main(List<String> args) {
  Platformer.global.specify("cli");
  dynamic api = FunctionalTree({
    "domain": {
      "specific": {
        "command": Environmentable({
          "any": (Map context, List<String> envs) {
            print("Command from any");
            print(context);
            print(envs);
            print(" ");
          },
          "gui": (Map context, List<String> envs) {
            print("Command from gui");
            print(context);
            print(envs);
            print(" ");
          },
          "nativeGui": (Map context, List<String> envs) {
            print("Command from nativeGui");
            print(context);
            print(envs);
            print(" ");
          },
          "os": (Map context, List<String> envs) {
            print("Command from os");
            print(context);
            print(envs);
            print(" ");
          },
          "server": (Map context, List<String> envs) {
            print("Command from server");
            print(context);
            print(envs);
            print(" ");
          },
          "cli": (Map context, List<String> envs) {
            print("Command from cli");
            print(context);
            print(envs);
            print(" ");
          },
          "web": (Map context, List<String> envs) {
            print("Command from web");
            print(context);
            print(envs);
            print(" ");
          }
        })
      }
    }
  });
  Inspector.inspect(api.domain.specific.command);
  Inspector.inspect(api.domain.specific.command.run);
  // @TODO: hacer un benchmarking de acceso directo por Map y acceso por noSuchMethod hack:
  // Benchmark 1 (acceso dinámico)
  DateTime start1 = DateTime.now();

  for(int i = 0; i < 5000; i++) {
    api.domain.specific.command.run({
      "message": "whatever",
      "path": [1,2,300,"what"],
    }, "nativeGui");
  }

  DateTime end1 = DateTime.now();
  Duration diff1 = end1.difference(start1);

  // Benchmark 2 (acceso por Map)

  DateTime start2 = DateTime.now();

  for(int i = 0; i < 5000; i++) {
    api["domain"]["specific"]["command"].run({
      "message": "whatever",
      "path": [1,2,300,"what"],
    }, "nativeGui");
  }

  DateTime end2 = DateTime.now();
  Duration diff2 = end2.difference(start2);

  print("Dynamic access time: " + (diff1.inMicroseconds/1000).toString() + " ms");
  print("Map access time: " + (diff2.inMicroseconds/1000).toString() + " ms");
}

