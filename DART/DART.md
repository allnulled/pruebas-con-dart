# Dart cheat sheet by allnulled

Chuleta para el lenguaje de Dart.

# Índice del documento

 - [Recursos](#recursos)
    - [Recursos relacionados con Dart](#recursos-relacionados-con-dart)
 - [Clases](#clases)
    - [Propiedades y métodos](#propiedades-y-métodos)
    - [Herencia simple](#herencia-simple)
    - [Herencia con abstract (abstract + extends)](#herencia-con-abstract-abstract-extends)
    - [Herencia con final](#herencia-con-final)
    - [Herencia con mixins (with)](#herencia-con-mixins-with)
    - [Herencia con interfaces (implements)](#herencia-con-interfaces-implements)
    - [Las anteriores combinadas a la vez](#las-anteriores-combinadas-a-la-vez)
    - [Un ejemplo práctico](#un-ejemplo-práctico)
 - [Estilos](#estilos)
    - [Introducción](#introducción)
    - [Componentes estilizantes](#componentes-estilizantes)
       - [Componente estilizante Align](#componente-estilizante-align)
       - [Componente estilizante Center](#componente-estilizante-center)
       - [Componente estilizante Container](#componente-estilizante-container)
       - [Componente estilizante DecoratedBox](#componente-estilizante-decoratedbox)
       - [Componente estilizante Expanded](#componente-estilizante-expanded)
       - [Componente estilizante Padding](#componente-estilizante-padding)
       - [Componente estilizante SizedBox](#componente-estilizante-sizedbox)
 - [Hook en compilación](#hook-en-compilación)
    - [Usos](#usos)
    - [Nota importante](#nota-importante)
    - [Paso 1. Añadir dependencias necesarias en el pubspec.yaml](#paso-1-añadir-dependencias-necesarias-en-el-pubspecyaml)
    - [Paso 2. Añadir la clase con el Builder específico](#paso-2-añadir-la-clase-con-el-builder-específico)
    - [Paso 3. Añadir el builder en el build.yaml](#paso-3-añadir-el-builder-en-el-buildyaml)
    - [Paso 4. Ejecutar el build](#paso-4-ejecutar-el-build)
 - [Hook en compilación para anotaciones](#hook-en-compilación-para-anotaciones)
    - [Paso 1. Añadir dependencias necesarias en el pubspec.yaml](#paso-1-añadir-dependencias-necesarias-en-el-pubspecyaml)
    - [Paso 2. Añadir la clase con el Builder específico](#paso-2-añadir-la-clase-con-el-builder-específico)
    - [Paso 3. Añadir el builder en el build.yaml](#paso-3-añadir-el-builder-en-el-buildyaml)
    - [Paso 4. Añadir la clase de la anotación](#paso-4-añadir-la-clase-de-la-anotación)
    - [Paso 5. Añadir las anotaciones en el código importando la anotación](#paso-5-añadir-las-anotaciones-en-el-código-importando-la-anotación)
    - [Paso 6. Buildear](#paso-6-buildear)
 - [Crear una línea de comandos simple](#crear-una-línea-de-comandos-simple)
    - [ Añadir el ejecutable en el pubspec](#1-añadir-el-ejecutable-en-el-pubspec)
    - [ Añadir la clase del ejecutable](#2-añadir-la-clase-del-ejecutable)
       - [Clase de entrada de ejecutable](#clase-de-entrada-de-ejecutable)
       - [Clase de lógica de ejecutable](#clase-de-lógica-de-ejecutable)
 - [Crear una línea de comandos con endpoints dinámicos](#crear-una-línea-de-comandos-con-endpoints-dinámicos)
 - [Crear un servidor simple](#crear-un-servidor-simple)
 - [Crear un servidor con endpoints dinámicos](#crear-un-servidor-con-endpoints-dinámicos)
 - [Crear rutas de aplicación cliente simple](#crear-rutas-de-aplicación-cliente-simple)
 - [Crear rutas de aplicación cliente con endpoints dinámicos](#crear-rutas-de-aplicación-cliente-con-endpoints-dinámicos)
 - [JSON parse y stringify](#json-parse-y-stringify)


#  Recursos

## Recursos relacionados con Dart

Generar código Dart con Gémini:

- [https://dart.dev/#try-dart](https://dart.dev/#try-dart)

Documentación oficial de Dart:

- [https://dart.dev/docs](https://dart.dev/docs)

Referencia de API oficial del Dart SDK:

- [https://api.dart.dev/](https://api.dart.dev/)

Para evaluar Dart directamente:

- [https://dartpad.dev/](https://dartpad.dev/)

Para pasar de código Dart a JavaScript:

- [https://www.codeconvert.ai/dart-to-javascript-converter](https://www.codeconvert.ai/dart-to-javascript-converter)

Para pasar de código Dart a C++:

- [https://www.codeconvert.ai/dart-to-c++-converter](https://www.codeconvert.ai/dart-to-c++-converter)

#  Clases

En esta sección se exploran las clases en Dart.

## Propiedades y métodos

```dart
class Ejemplo {

  // Propiedades dinámicas
  String name = "default";
  final String fixedName = "fixed";
  int? age;

  String get nickname => name;

  // Propiedades estáticas
  static String appName = "App";
  static final String version = "1.0";
  static const int year = 2026;

  static String get label => "Label";
  static set label(String l) {}

  // Constructor
  Ejemplo(name, age) {
    this.name = name;
    this.age = age;
  }

  // Métodos dinámicos
  void greet() {
    print("Hi $name");
  }

  String get greeting => "Hi $name";

  set greeting(String val) {
    name = val;
  }

  // Métodos estáticos
  static void staticGreet() {
    print("Hi App");
  }

  static String get staticGreeting => "Hi App";

  static set staticGreeting(String val) {}
}

void main() {}
```

En JS equivaldría a:

```dart
class Ejemplo {

  String name = "";
  int _age = 0;

  // Constructor
  constructor(name, age) {
    this.name = name; // mutable per instance
    this._age = age;  // assignable only in constructor
  }

  // Instance property: age (read-only)
  get age {
    return this._age;
  }

  // Instance property: nickname (read-only)
  get nickname {
    return name;
  }

  // Instance methods
  greet() {
    print("Hi ${name}");
  }

  get greeting {
    return "Hi ${name}";
  }

  set greeting(val) {
    name = val;
  }

  // Static properties
  static String appName = "App";          // mutable, class-level
  static String version = "1.0";          // final per class (no enforced immutability in JS)
  static int year = 2026;              // compile-time const equivalent

  static get label {
    return "Label";
  }

  static set label(l) {
    // empty setter
  }

  // Static methods
  static staticGreet() {
    print("Hi App");
  }

  static get staticGreeting {
    return "Hi App";
  }

  static set staticGreeting(val) {
    // empty setter
  }
}
void main (){}
```

## Herencia simple

```dart
class A {
  void hello() => print("Hello A");
}

class B extends A {
  void bye() => print("Bye B");
}

void main() {
  final b = B();
  b.hello(); // ✅ heredado
  b.bye();   // ✅ propio
}
```

## Herencia con abstract (abstract + extends)

Las clases abstractas:

- No se pueden instanciar.
- Obligan a las subclases a implementar métodos abstractos.
- Puede contener métodos concretos también.

```dart
abstract class Animal {
  void speak();  // abstract, obliga a implementar
}

class Dog extends Animal {
  @override
  void speak() => print("Woof");
}
void main (){}
```

## Herencia con final

La final class:

- No puede ser extendida.
- Solo se pueden crear instancias de la misma clase (útil para singletons).

```dart
final class Singleton {
  static final Singleton instance = Singleton._internal();
  Singleton._internal(); // constructor privado
}
void main (){}
```

## Herencia con mixins (with)

- Puedes usar varios a la vez sobre 1 clase.
- No puedes instanciar un mixin suelto.
- Antes se podía pedir una clase base desde el mixin, pero ya no.

```dart
mixin Flyer {
  void fly() => print("Flying");
}

mixin Runner {
  void run() => print("Running");
}

mixin Swimmer {
  void swim() => print("Swiming");
}

class Bird with Flyer {}

class SuperHero with Flyer, Swimmer, Runner {}

void main() {
  Bird b = Bird();
  b.fly(); // ✅ hereda del mixin

  SuperHero s = SuperHero();
  s.fly();
  s.swim();
  s.run();
}
```

## Herencia con interfaces (implements)

- Obligatorio sobrescribir todos los métodos de la interfaz.
- No heredas implementación, solo el “contrato”.

```dart
abstract class Animal {
  void sayHi();
}

class Robot implements Animal {
  @override
  void sayHi() => print("Beep");
}

void main () {}
```

## Las anteriores combinadas a la vez

```dart
abstract class Comparable<T> {
  int compareTo(T other);
}

class Bird extends Animal {
    void eat() {}
    void pio() {}
}

class Cat extends Animal {
    void eat() {}
    void miau() {}
}

abstract class Animal {
  void eat();
}

mixin Runner {
  void run() => print("Running");
}

mixin Flyer {
  void fly() => print("Flying");
}

class CatBird extends Animal with Flyer, Runner implements Comparable<Animal> {
  @override
  void eat() => print("Eating");

  @override
  int compareTo(Animal other) => 0;
}

void main (){}
```

## Un ejemplo práctico

A la hora de la verdad, seguramente esta sería la fórmula más usada:

```dart
mixin HasName {
    String name = "some";
}

mixin HasLegs {
    Boolean hasLegs = true;
}

mixin CanWalk on HasName, HasLegs {
    void walk() {
        print("${name} is walking");
    }
}

class Human with HasName, HasLegs, CanWalk {
    String name = "Human";
}

void main() {
    Human().walk();
}
```

Lo cual en JavaScript se vería así:

```js
const HasName = Base => class extends Base {
    constructor(...args) {
        super(...args);
        this.name = "some";
    }
};

const HasLegs = Base => class extends Base {
    constructor(...args) {
        super(...args);
        this.hasLegs = true;
    }
};

const CanWalk = Base => class extends Base {
    walk() {
        console.log(`${this.name} is walking`);
    }
};

class Human extends CanWalk(HasLegs(HasName(class {}))) {
    constructor() {
        super();
        this.name = "Human";
    }
}

function main() {
    new Human().walk();
}

main();
```

#  Estilos

En esta sección trataremos cómo se manejan los estilos en Dart.

## Introducción

- Cada componente tiene su propia forma de estilos

## Componentes estilizantes

- [Introducción](#introducción)
- [Componentes estilizantes](#componentes-estilizantes)
  - [Componente estilizante Align](#componente-estilizante-align)
  - [Componente estilizante Center](#componente-estilizante-center)
  - [Componente estilizante Container](#componente-estilizante-container)
  - [Componente estilizante DecoratedBox](#componente-estilizante-decoratedbox)
  - [Componente estilizante Expanded](#componente-estilizante-expanded)
  - [Componente estilizante Padding](#componente-estilizante-padding)
  - [Componente estilizante SizedBox](#componente-estilizante-sizedbox)


### Componente estilizante Align

```dart

```

### Componente estilizante Center

```dart

```

### Componente estilizante Container

```dart
Container(
  margin: const EdgeInsets.all(10.0),
  color: Colors.amber[600],
  width: 48.0,
  height: 48.0,
)
```

### Componente estilizante DecoratedBox

```dart

```

### Componente estilizante Expanded

```dart

```

### Componente estilizante Padding

```dart
Padding(
  padding: EdgeInsets.all(16.0),
  child: Text('Hello World!'),
);
```

### Componente estilizante SizedBox

```dart

```

#  Hook en compilación

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

#  Hook en compilación para anotaciones

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

#  Crear una línea de comandos simple

Para crear una línea de comandos simple con Dart, sigue leyendo.

## 1. Añadir el ejecutable en el pubspec

En el `pubspec` tiene que aparecer la ruta al ejecutable global:

```yaml
# Esto es para especificar un binario
executables:
  boj: lib/toolkit/boj/binary.dart
```

## 2. Añadir la clase del ejecutable

Podría estar todo en 1 clase, pero en este ejemplo vamos a hacer 1 fichero para el binario, y otro para la clase que gestiona la lógica. Esto es para diferenciar la entrada desde línea de comandos, y la API que gestiona la lógica de la línea de comandos, y poder reaprovecharla a nivel de API también.

Por eso, crearemos 2 ficheros nuevos para gestionar el ejecutable:

- Clase de entrada: `lib/toolkit/boj/binary.dart`
- Clase de lógica: `lib/toolkit/boj/api/BojCommandLineInterface.dart`

### Clase de entrada de ejecutable

En el fichero `lib/toolkit/boj/binary.dart` algo como:

```dart
#!/usr/bin/env dart

import 'package:fluttagenda/toolkit/boj/BojFramework.dart';

void main(List<String> args) {
  BojFramework.global.cli.start(args);
}
```

### Clase de lógica de ejecutable

Continuaríamos en otro fichero `lib/toolkit/boj/api/BojCommandLineInterface.dart`:

```dart
import 'package:fluttagenda/toolkit/boj/BojFramework.dart';

class BojCommandLineInterface {

  final BojFramework boj;
  
  BojCommandLineInterface(this.boj);

  void start(List <String> args) {
    print(args);
  }

}
```

#  Crear una línea de comandos con endpoints dinámicos

Linea de comandos con endpoints dinámicos basados en JSON.

#  Crear un servidor simple

Servidor con endpoints dinámicos basados en JSON.

#  Crear un servidor con endpoints dinámicos

Servidor con endpoints dinámicos basados en JSON.

#  Crear rutas de aplicación cliente simple

Rutas con endpoints dinámicos basados en JSON.

#  Crear rutas de aplicación cliente con endpoints dinámicos

Rutas con endpoints dinámicos basados en JSON.

# JSON parse y stringify

```dart
import 'dart:convert';

void main() {
  print(json.encode(List.from([1, 2, 3])));
  print(json.encode(List.from(['foo', 'bar', 'dart'])));
  print(json.encode({'a': 1, 'b': 2}));
  print(json.decode('{"a":1,"b":2}'));
}
```

