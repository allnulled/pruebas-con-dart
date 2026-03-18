import 'dart:async';
import 'package:build/build.dart';

Builder holaBuilder(BuilderOptions options) {
  return HolaBuilder();
}

class HolaBuilder implements Builder {

  @override
  Map<String, List<String>> get buildExtensions => {
    r'$package$': ['hola.txt'],
  };

  @override
  Future<void> build(BuildStep buildStep) async {
    final output = AssetId(buildStep.inputId.package, 'hola.txt');
    await buildStep.writeAsString(output, 'en compilation-time');
  }
}