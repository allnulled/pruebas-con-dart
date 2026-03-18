import 'package:flutter/material.dart';
import "../../BojFramework.dart";

class BojTheme {

  final BojFramework boj;

  BojTheme(BojFramework this.boj);

  ThemeData from(BuildContext context) {
    return Theme.of(context);
  }

}