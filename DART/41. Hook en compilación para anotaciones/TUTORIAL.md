En el punto anterior vimos cómo hacer un hook mínimo en el builder.

Ahora, vamos a hacer un hook en el builder que nos permita leer las anotaciones escritas en los ficheros fuente `*.dart` de todo nuestro proyecto (con glob) y generar un fichero (con código dart, usado en runtime).

## Paso 1. Añadir dependencias necesarias en el pubspec.yaml

Esto se ha explicado en el punto anterior, y con hacerlo 1 vez ya estaría.

Sin embargo, en este caso estamos usando alguna librería más, así que la cosa queda así:

Esto es el `dev_dependencies` del `pubspec.yaml`:

```yaml
dev_dependencies:
  build_web_compilers: ^4.4.12
  flutter_test:
    sdk: flutter
  # Estos son los que hemos añadido en el tutorial anterior
  build_runner: ^2.4.0
  build: ^2.4.0
  # Estos son los que hemos añadido en este tutorial
  analyzer: ^6.4.0
  glob: ^2.1.2
  # The "flutter_lints" package below contains a set of recommended lints to
  # encourage good coding practices. The lint set provided by the package is
  # activated in the `analysis_options.yaml` file located at the root of your
  # package. See that file for information about deactivating specific lint
  # rules and activating additional ones.
  flutter_lints: ^6.0.0

```

## Paso 2. Añadir la clase con el Builder específico

Estamos en el fichero: `lib/toolkit/boj/builders/boj_exposers/BojExposersBuilder.dart`.

El contenido quedaría así:

```dart
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
```

## Paso 3. Añadir el builder en el build.yaml

El build.yaml con el ejemplo anterior nos estaría quedando así:

```yaml
targets:
  $default:
    builders:
      # Estos son los que hemos añadido en el tutorial anterior
      fluttagenda|hola_builder:
        enabled: true
      # Estos son los que hemos añadido en este tutorial
      fluttagenda|boj_exposers_builder:
        enabled: true

builders:
  # Estos son los que hemos añadido en el tutorial anterior
  hola_builder:
    import: "package:fluttagenda/toolkit/boj/builders/hello/HelloBuilder.dart"
    builder_factories:
      - holaBuilder
    build_extensions:
      "$package$":
        - hola.txt
    auto_apply: root_package
    build_to: source
  # Estos son los que hemos añadido en este tutorial
  boj_exposers_builder:
    import: "package:fluttagenda/toolkit/boj/builders/boj_exposers/BojExposersBuilder.dart"
    builder_factories:
      - bojExposersBuilder
    build_extensions:
      "$package$":
        - exposers.txt
    auto_apply: root_package
    build_to: source
```

## Paso 4. Añadir la clase de la anotación

Necesitas la clase que construye la anotación, tan simple como una clase a pelo:

Estamos en el fichero del proyecto `lib/toolkit/boj/annotations/Expose.dart`:

```dart
class Expose {
  final String name;
  final List<dynamic> options;
  const Expose(this.name, [this.options = const []]);
}
```

## Paso 5. Añadir las anotaciones en el código importando la anotación

Ahora solo tenemos que ir anotando sobre los métodos que queramos:

```dart
import 'package:fluttagenda/toolkit/boj/annotations/Expose.dart';

class BojFichero1 {

  @Expose("texto", [])
  void hello() {
    print("Hello from BojFichero1.hello");
  }

}
```

## Paso 6. Buildear

Para compilar las anotaciones, solo te falta:

```sh
dart run build_runner build
```

En `exposer.json` ya nos aparece el nuevo contenido:

```json
[{"class":"BojWidgets","method":"hello"}]
```

¡Perfecto!

A partir de ahora ya podremos recoger datos de las anotaciones y usarlos en tiempo de ejecución, o de compilación.