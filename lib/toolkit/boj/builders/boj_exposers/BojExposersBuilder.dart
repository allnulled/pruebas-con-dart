import 'dart:async';
import 'dart:convert';
import 'package:build/build.dart';
import 'package:glob/glob.dart';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';

Builder bojExposersBuilder(BuilderOptions options) {
  return BojExposersBuilder();
}

class BojExposersBuilder implements Builder {
  
  @override
  Map<String, List<String>> get buildExtensions => {
    r'$package$': ['exposer.json'],
  };

  @override
  Future<void> build(BuildStep buildStep) async {
    var files = buildStep.findAssets(Glob('lib/toolkit/boj/api/*.dart'));
    List exposers = [];
    await for (var asset in files) {
      var source = await buildStep.readAsString(asset);
      var unit = parseString(content: source).unit;
      for (var decl in unit.declarations) {
        if (decl is ClassDeclaration) {
          for (var member in decl.members) {
            if (member is MethodDeclaration) {
              for (var annotation in member.metadata) {
                if (annotation.name.name == 'Expose') {
                  exposers.add({
                    "class": decl.name.lexeme,
                    "method": member.name.lexeme,
                  });
                }
              }
            }
          }
        }
      }
    }
    String exposersJson = json.encode(exposers);
    await buildStep.writeAsString(AssetId(buildStep.inputId.package, "exposer.json"), exposersJson);
  }

}