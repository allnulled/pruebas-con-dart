Un hook en compilación te permite hacer algo en el builder integrado de Dart/Flutter.

## Usos

Entre los hooks del builder van los hooks para extraer anotaciones del código y generar código en *compilation-time*, por ejemplo.

Pero este ejemplo es minimalista, y solo generará un fichero plano diciendo hola.

## Nota importante

> El código de este tipo de hook **no se ejecuta** al presionar CTRL+S, F5 ni CTRL+F5 con la extensión de VSCode para Dart/Flutter. Ahí solo se ejecuta el analyzer y algo más, y según ChatGPT no se puede hookear.

> El código de este tipo de hook **sí se ejecuta** al hacer `$ dart run build_runner build` desde la consola.

## Paso 1. Añadir dependencias necesarias en el pubspec.yaml

Añadir estas dependencias en el fichero `pubspec.yaml`:

```yaml
dev_dependencies:
  build_runner: ^2.4.0
  build: ^2.4.0
```

## Paso 2. Añadir la clase con el Builder específico

En el caso del proyecto en el que estoy, tengo una carpeta de builders propios del framework que estoy construyendo, en:

- `lib/toolkit/boj/builders`

Y concretamente, este ejemplo lo estoy generando en:

- `lib/toolkit/boj/builders/hello/HelloBuilder.dart`

El contenido de este fichero es:

```dart
import 'dart:async';
import 'package:build/build.dart';

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
```

## Paso 3. Añadir el builder en el build.yaml

El fichero `build.yaml`, y añadimos la referencia del builder:

```yaml
targets:
  $default:
    builders:
      fluttagenda|hola_builder:
        enabled: true

builders:
  hola_builder:
    import: "package:fluttagenda/toolkit/boj/builders/hello/HelloBuilder.dart"
    builder_factories:
      - holaBuilder
    build_extensions:
      "$package$":
        - hola.txt
    auto_apply: root_package
    build_to: source
```

## Paso 4. Ejecutar el build

Ahora, cuando corramos:

```sh
dart run build_runner build
```

Se generará un fichero `hola.txt` en la raíz del proyecto con el contenido `en compilation-time`.


No es gran cosa, pero es el ejemplo mínimo para empezar a hacer cosas.