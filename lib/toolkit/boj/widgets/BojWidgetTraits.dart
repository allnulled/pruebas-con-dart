import 'package:flutter/material.dart';
import '../BojFramework.dart';

class BojWidgetTraits {

  String getVersion() {
    return BojFramework.global!.version;
  }

}