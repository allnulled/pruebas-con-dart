import 'package:flutter/material.dart';
import "../../BojFramework.dart";

class BojGraphicalUserInterface {

  final BojFramework boj;

  BojGraphicalUserInterface(this.boj);

  dynamic start(List args) {
    return Function.apply(runApp, args);
  }

}