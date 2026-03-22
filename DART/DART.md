# Dart cheat sheet by allnulled

Chuleta para el lenguaje de Dart.

# Índice del documento

 - [Recursos](#recursos)
    - [Recursos relacionados con Dart](#recursos-relacionados-con-dart)
 - [Crear un sistema de comandos polientorno](#crear-un-sistema-de-comandos-polientorno)
    - [Requisitos](#requisitos)
    - [Objetivos](#objetivos)
 - [Clases](#clases)
    - [Propiedades y métodos](#propiedades-y-métodos)
    - [Herencia simple](#herencia-simple)
    - [Herencia con abstract (abstract + extends)](#herencia-con-abstract-abstract-extends)
    - [Herencia con final](#herencia-con-final)
    - [Herencia con mixins (with)](#herencia-con-mixins-with)
    - [Herencia con interfaces (implements)](#herencia-con-interfaces-implements)
    - [Las anteriores combinadas a la vez](#las-anteriores-combinadas-a-la-vez)
    - [Un ejemplo práctico](#un-ejemplo-práctico)
 - [Modulación con imports y exports](#modulación-con-imports-y-exports)
    - [Técnicas específicas](#técnicas-específicas)
       - [Consejo 1. Usar import con rutas relativas es mejor que con rutas de paquete](#consejo-1-usar-import-con-rutas-relativas-es-mejor-que-con-rutas-de-paquete)
       - [Consejo 2. Imports condicionales para clases opinionadas en entorno](#consejo-2-imports-condicionales-para-clases-opinionadas-en-entorno)
          - [Punto 1. Las 3 carpetas de entorno](#punto-1-las-3-carpetas-de-entorno)
          - [Punto 2. Los imports condicionales en los puntos de entrada más altos](#punto-2-los-imports-condicionales-en-los-puntos-de-entrada-más-altos)
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
    - [Paso 1. Añadir el ejecutable en el pubspec](#paso-1-añadir-el-ejecutable-en-el-pubspec)
    - [Paso 2. Añadir la clase del ejecutable](#paso-2-añadir-la-clase-del-ejecutable)
       - [Paso 3. Instalar ejecutable](#paso-3-instalar-ejecutable)
       - [Paso 4. Parsear los argumentos](#paso-4-parsear-los-argumentos)
       - [Paso 5. Reinstalar la CLI para actualizar los cambios](#paso-5-reinstalar-la-cli-para-actualizar-los-cambios)
 - [Crear un servidor simple](#crear-un-servidor-simple)
 - [Patrón singleton en static inicializado en el primer constructor](#patrón-singleton-en-static-inicializado-en-el-primer-constructor)
 - [Crear un árbol funcional](#crear-un-árbol-funcional)
    - [¿Qué necesidad?](#qué-necesidad)
    - [La clase FunctionalTree](#la-clase-functionaltree)
    - [Objetivo](#objetivo)
    - [Lo que no es](#lo-que-no-es)
       - [Test de FunctionalTree](#test-de-functionaltree)
       - [Implementación final de FunctionalTree](#implementación-final-de-functionaltree)
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

#  Crear un sistema de comandos polientorno

¿Qué significa sistema de comandos polientorno?

Significa un sistema de comandos compatible con:

- entorno de línea de comandos
- entorno de petición de servidor http
- entorno de aplicación gráfica

## Requisitos

Se juntan 3 secciones anteriores:

- [Crear un árbol funcional](#)
   - nos permite dinamizar el acceso a las funciones de cada comando
   - nos permite acceder vía cliente gráfico
- [Crear una línea de comandos simple](#)
   - nos permite acceder vía línea de comandos
- [Crear un servidor simple](#)
   - nos permite acceder vía servidor HTTP

## Objetivos






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

#  Modulación con imports y exports

Las técnicas de import y export de módulos de Dart te interesa entenderlas bien porque son la clave de la modulación.

Según qué utilices y cómo, resulta en una cosa u otra.

## Técnicas específicas

En esta sección voy a hacer una lista de las técnicas de uso de **import** y **export** que parecen haber funcionado en los primeros pasos al menos.

### Consejo 1. Usar import con rutas relativas es mejor que con rutas de paquete

Con los `imports` con sus rutas relativas, el entorno del `cli` puede importar los ficheros sin conocer el proyecto.

Aquí se ven las 2 formas de importar:

```dart
// Rutas relativas son así:
import "ruta/a/fichero.dart";
import "./ruta/a/fichero.dart";
import "../ruta/a/fichero.dart";
// Rutas de paquete son así:
import "package:mipaquete/ruta/relativa/desde/lib/a/fichero.dart";
```

Si en el `pubspec.yaml#name` tienes `mipaquete`, puedes usarlo como ruta relativa global.

Pero pierdes eso, que un binario satelital pueda importar el framework sin conocer el proyecto.

Por eso, de momento al menos, rutas relativas, **pese a lo que diga ChatGPT**.

### Consejo 2. Imports condicionales para clases opinionadas en entorno

Cuando digo entorno, me refiero a 2 casos principalmente:

- `os`: caso de aplicación de sistema operativo (linux, windows, etc.)
   - discriminable con `import "pascual" if (dart.library.io);`
- `ui`: caso de aplicación de interfaz de usuario (web, android, gtk, win, etc.)
   - discriminable con `import "pascual" if (dart.library.ui);`

#### Punto 1. Las 3 carpetas de entorno

En cualquier punto de la estructura de ficheros de la API, deberías poder meter 3 carpetas:

- `env.any`
   - Aquí irán las clases/interfaces comunes en cualquier entorno
   - Normalmente serán clases vacías
- `env.os`
   - Aquí irán las clases/interfaces que solo cargarán en entorno `os`
- `env.ui`
   - Aquí irán las clases/interfaces que solo cargarán en entorno `ui`

#### Punto 2. Los imports condicionales en los puntos de entrada más altos



Para que no toda la API tenga siempre que estar bajo la carpeta `env.ui`, lo que haces es:

- Solo poner dentro de `env.ui` las clases que se requieren en el código no opinionado en entorno.
   - A esto me refiero con el punto de entrada más alto
      - Al punto más alto del árbol donde se enganchan con la API no opinionada de entorno (la básica).
   - Estas clases sí se tienen que usar con imports condicionales
   - Porque estarán accesibles desde el código no opinionado en entorno y hay que resolvérselas
   - Pero más allá:
- La API opinionada en entorno, ponerla en otra carpeta
   - **SIN USAR IMPORTS CONDICIONALES**
   - La prueba final de que lo haces bien es que:
      - La aplicación sigue funcionando bien en distintos entornos
      - Pero estas clases (de API opinionada en entorno) ya no usan `import + if`
      - *Porque la clase de la que cuelgan no va a usar ninguno de esos métodos o propiedades* y Dart no se quejará
      - Solo en código entorno-opinionado se verán explotadas esas clases.

El código de los imports queda así:

```dart
import "api/BojDebug.dart";
import "api/BojUtils.dart";
import "api/BojCommandLine.dart";
import "api/env.any/BojWidgets.dart" if (dart.library.ui) "api/env.ui/BojWidgetsOnUi.dart";
import "api/env.any/BojServer.dart" if (dart.library.io) "api/env.os/BojServerOnOs.dart";
import "api/env.any/BojGraphicalUserInterface.dart" if (dart.library.ui) "api/env.ui/BojGraphicalUserInterfaceOnUi.dart";
import "api/env.any/BojTheme.dart" if (dart.library.ui) "api/env.ui/BojThemeOnUi.dart";

// Exportar extensiones:
export "extensions/env.any/StyleExtensions.dart" if (dart.library.ui) "extensions/env.ui/StyleExtensionsOnUi.dart";
```

Ahora mismo, está así así. Seguramente, lo ideal máximo es reducir a 1 solo:

- `if(dart.library.ui) "api-grafica.dart"`

Ahora mismo hay varias capas de alto nivel que incurren ahí, y por eso hay varios imports condicionales.

> Seguramente, lo mejor fuera que las clases `BojWidgets` y `BojTheme` estuvieran dentro de `BojGraphicalUserInterfaceOnUi`. De momento está así, porque estamos probando soluciones y afinando el criterio de buenas prácticas de Dart, para ver cómo se espera resolver esto (ChatGPT está ayudando, pero está dando falsas pistas también, **hay que mirar la documentación oficial** para irse aclarando de verdad).

Este patrón antes era más largo, y con condicionales que cargaban clases o no. Pero este approach permite hacerlo sin condicionales que es como recomendaba ChatGPT.

La clase final queda así:

```dart
class BojFramework {

  late String environmentId;
  late BojUtils utils;
  late BojDebug debug;
  late BojWidgets widgets;
  late BojGraphicalUserInterface gui;
  late BojCommandLine cli;
  late BojServerInterface server;
  late BojTheme theme;

  BojFramework(this.environmentId) {
    utils = BojUtils(this);
    debug = BojDebug(this);
    cli = BojCommandLine(this);
    server = BojServerInterface(this);
    widgets = BojWidgets(this);
    gui = BojGraphicalUserInterface(this);
    theme = BojTheme(this);
  }

}
```

Otra cosa importante es qué tienen las clases, las vacías `env.any` y las opinionadas `env.ui` y `env.os`.

La clase de los widgets, que sería la más cargada de todas, empieza así en el `env.any`:

```dart
// File: lib/toolkit/boj/api/env.any/BojWidgets.dart
import '../../BojFramework.dart';

class BojWidgets {
  final BojFramework boj;

  late Function Box;
  late Function HorizontalBox;
  late Function VerticalBox;
  late Function ControlForLine;
  late Function ControlForMultiline;
  late Function StatefulWidget;
  late Function StatelessWidget;

  BojWidgets(this.boj);
}
```

Igual puede llegar a reducirse a interfaz, o clase abstracta, para asegurarse que esta clase no se usa.

**O incluso puede que sea posible vaciar todavía más el contenido** si no lo vas a usar en código no opinionado.

La clase opinionada queda así en cambio:

```dart
// File: lib/toolkit/boj/api/env.ui/BojWidgetsOnUi.dart
export "../../extensions/env.ui/StyleExtensionsOnUi.dart";
import "../../BojFramework.dart";
import "../../widgets/BojBox.dart";
import "../../widgets/BojHorizontalBox.dart";
import "../../widgets/BojVerticalBox.dart";
import "../../widgets/BojStatefulWidget.dart";
import "../../widgets/BojStatelessWidget.dart";
import "../../widgets/BojControlForLine.dart";
import "../../widgets/BojControlForMultiline.dart";
import '../../annotations/Expose.dart';

class BojWidgets {
  final BojFramework boj;

  late Function Box;
  late Function HorizontalBox;
  late Function VerticalBox;
  late Function ControlForLine;
  late Function ControlForMultiline;
  late Function StatefulWidget;
  late Function StatelessWidget;

  BojWidgets(this.boj) {
    // Aquí inicializamos tranquilamente las instancias internas y Dart no se quejará
    // Concretamente, en el caso de los widgets, no nos interesan instancias, sino la función constructora de cada clase
    Box = BojBox.new;
    ControlForLine = BojControlForLine.new;
    ControlForMultiline = BojControlForMultiline.new;
    HorizontalBox = BojHorizontalBox.new;
    VerticalBox = BojVerticalBox.new;
    StatefulWidget = BojStatefulWidget.new;
    StatelessWidget = BojStatelessWidget.new;
  }

  // Esto en este caso no nos importa porque no es el tema
  @Expose("texto", [])
  void hello() {
    print("Hello from BojWidgets.prototype.hello:void");
  }

}
```

Es una versión muy minimal todavía, pero ya se ve el patrón a seguir para que pueda escalar.

En cuanto al sufijo `OnUi` y `OnOs` en las clases, son opcionales, pero aclaran el entorno, que es algo muy troncal.

De momento, la manera oficial de permitir APIs multientorno sería esta.

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

Para crear una línea de comandos simple con Dart, sigue los pasos que se explican a continuación.

- Paso 1. Añadir el ejecutable en el pubspec
- Paso 2. Añadir la clase del ejecutable
- Paso 3. Instalar ejecutable
- Paso 4. Parsear los argumentos
- Paso 5. Reinstalar la CLI para actualizar los cambios

## Paso 1. Añadir el ejecutable en el pubspec

En el `pubspec` tiene que aparecer la ruta al ejecutable global:

```yaml
# Esto es para especificar un binario
executables:
  boj: lib/toolkit/boj/binary.dart
```

## Paso 2. Añadir la clase del ejecutable

En un fichero `bin/boj.dart` algo así:

```dart
#!/usr/bin/env dart

void main(List<String> args) {
  print("Bienvenido al CLI");
}
```

### Paso 3. Instalar ejecutable

Con esto se instala en el sistema:

```sh
dart pub global activate --source path .
```

Le hemos dicho que se llama `boj` en el pubspec, así que podremos usarlo desde línea de comandos:

```sh
boj subc1 subc2 --flag --text whatever --param1 t1 t2 t3 --param3 200
```

### Paso 4. Parsear los argumentos

Los últimos pasos, en tanto que una CLI, son:

- parsear los argumentos
- redirigir a otra API la llamada (un switch-case)

La estrategia de parseo de argumentos a usar va a ser la típica:

- argumentos posicionales: `micli pos1 pos2 pos3 pos4`
- argumentos nominales, con soporte para:
   - booleano: `--flag`
   - número: `--number 500`
   - texto: `--text Text --text "texto con espacios"`
   - array de textos: `--array texto1 "texto 2 con espacios" texto3`

Esto lo conseguiríamos con esta clase y su método estático `compile`:

```dart
#!/usr/bin/env dart

class ProgramArguments {

  static Map compile(List<String> args) {
    Map argc = {};
    List positional = [];
    argc["_"] = positional;
    int i = 0;
    while (i < args.length) {
      String arg = args[i];
      bool isFlag = arg.startsWith("--");
      if (isFlag == false) {
        positional.add(arg);
        i = i + 1;
        continue;
      }
      String key = arg.substring(2);
      int j = i + 1;
      List values = [];
      while (j < args.length) {
        String next = args[j];
        bool nextIsFlag = next.startsWith("--");
        if (nextIsFlag) {
          break;
        }
        values.add(next);
        j = j + 1;
      }
      if (values.isEmpty) {
        argc[key] = true;
      } else if (values.length == 1) {
        String v = values[0];
        int? asInt = int.tryParse(v);
        double? asDouble = double.tryParse(v);
        if (asInt != null) {
          argc[key] = asInt;
        } else if (asDouble != null) {
          argc[key] = asDouble;
        } else {
          argc[key] = v;
        }
      } else {
        argc[key] = values;
      }
      i = j;
    }
    return argc;
  }

}

void main(List<String> args) {
  Map argc = ProgramArguments.compile(args);
  print(argc);
}
```

### Paso 5. Reinstalar la CLI para actualizar los cambios

Si ejecutas directamente el script, no hay problema, y los cambios se actualizan automáticamente.

Pero si compilas e instalas global a través de dart, hace cosas raras (al menos, de momento son cosas raras).

Tengo este script para reinstalarlo, pero todavía es insuficiente (`fluttagenda` es el nombre del proyecto de prueba):

```sh
dart pub global deactivate fluttagenda
dart pub cache gc
dart build cli
dart pub global activate --source path . --overwrite
```

Y no sirve. Hay que seguir escarbando por este lado.

Mientras tanto, uso el binario desde línea de comandos directamente, en lugar del global instalado por dart, que no obedece a los cambios (no sé por qué).

#  Crear un servidor simple

Para crear un servidor HTTP simple con Dart, primero hay que definir simple.

Un servidor HTTP simple sería uno que:

- parsea parámetros de la URL
   - los del path
   - los del query
- parsea parámetros del body
   - solo tipo JSON
- permite definir el handler de peticiones

Con esta abstracción, ya podemos abarcar los casos de HTTP más simples.

```dart
#!/usr/bin/env dart

import 'dart:io';
import 'dart:convert' show jsonDecode, jsonEncode, utf8;

class SimpleServer {

  final Future handler;

  SimpleServer(this.handler);

  static Future start(Map config) async {
    String host = config["host"] ?? "0.0.0.0";
    int port = config["port"] ?? 3000;
    HttpServer server = await HttpServer.bind(host, port);
    print("[*] Listening on http://$host:$port");
    await for (HttpRequest req in server) {
      await handleRequest(req);
    }
  }

  static Future handleRequest(HttpRequest req) async {
    String method = req.method;
    Uri uri = req.uri;
    String path = uri.path;
    Map query = {};
    Map queryRaw = uri.queryParameters;
    List qkeys = queryRaw.keys.toList();
    for(int i=0;i<qkeys.length;i++){
      String k = qkeys[i];
      query[k] = queryRaw[k];
    }
    Object? body = await parseBody(req);
    Map action = {
      "method": method,
      "path": path.split("/").where((String part) => part != "").toList(),
      "query": query,
      "body": body
    };
    print(action);
    req.response.headers.contentType = ContentType.json;
    Map answer = {
      "status": "ok",
      "in": action,
      "out": null,
    };
    String jsonAnswer = jsonEncode(answer);
    req.response.write(jsonAnswer);
    await req.response.close();
  }

  static Future parseBody(HttpRequest req) async {
    if(req.method == "GET" || req.method == "HEAD"){
      return null;
    }
    String raw = await utf8.decoder.bind(req).join();
    if(raw.isEmpty){
      return null;
    }
    String contentType = req.headers.contentType?.mimeType ?? "";
    if(contentType == "application/json"){
      try {
        return jsonDecode(raw);
      } catch(e) {
        return raw;
      }
    }
    return raw;
  }

}

Future main(List<String> args) async {
  await SimpleServer.start({
    "host": "0.0.0.0",
    "port": 3000
  });
}
```

#  Patrón singleton en static inicializado en el primer constructor

Este patrón es para que:

#  Crear un árbol funcional

## ¿Qué necesidad?

La necesidad del switcher funcional multidimensional o árbol funcional es:

> Dinamizar el acceso a datos ordenados.

Esto tiene 1 pro y 1 contra:

- PRO: Permite que en runtime se puedan acceder a diferentes tipos de variables.
- CONTRA: Rompe la tipación de Dart

Pero los pros continúan, así que no me voy a parar a debatir aquí.

## La clase FunctionalTree

Con esta clase:

- Dinamizamos el acceso a datos
- Dinamizamos la llamada a funciones

Esto es el core de un lenguaje de scripting on-top-of. El único requisito en Dart es este:

> Los datos deben ser `Map`, `List`, `Function` o primitivos.

## Objetivo

El objetivos intermedios se configuran como construir una API:

- *basada en árbol y funciones*
- **no basada clases y métodos**

La distinción es sutil, pero contundente en el runtime:

- los mapas se pueden inspeccionar y alterar en runtime
   - y los árboles no
- las funciones se pueden inspeccionar y alterar en runtime
   - y los métodos no

Perdemos rigor y formalidad en el código, pero solamente hasta cierto punto:

- porque tú por dentro de las funciones puedes seguir aprovechándote de los tipos
- porque tú incluso puedes decorar el árbol con instancias de clases

Lo que va a dar problemas es:

- decorar el árbol con clases o métodos.

Esto es lo que despierta una de las grandes desventajas de este acercamiento:

- no es un introspector de clases ni métodos
- no usa la reflection/mirrors de dart
- no explora el árbol de clases ya cargado en memoria
- únicamente te permite dinamizar el acceso, la modificación y la ejecución dentro de una estructura tipo Map.

Pero es una solución muy óptima en comparación porque:

- evitamos arrastrar toda la lógica necesaria para hacer ingeniería inversa de:
   - lo que puede haber en una clase Dart
   - lo que puede haber en una propiedad de clase Dart
   - lo que puede haber en un método de clase Dart
   - incluyendo lógica de tipos, herencia, anotaciones, etc.
- sin embargo, igualmente conseguimos:
   - el acceso dinámico en runtime
   - la modificación dinámica en runtime
   - la ejecución dinámica en runtime
   - y todo con la menor huella en memoria posible: mapas, funciones y un par de hacks que permite Dart.

Por eso, es una buena opción.

Lo siguiente es articular ya un lenguaje de scripting, para cubrir todos los bindings de bajo nivel con strings. Pero:

> Entre esta clase, más o menos sencilla, y un lenguaje de scripting full-equiped, hay una notoria y considerable complejidad, tanto desde la perspectiva humana como de la computación.

Y por esa diferencia de coste, esta estructura es importante:

> Dinamizar datos y ejecución en runtime con una clase mínima.

## Lo que no es

Esta clase no es:

- una herramienta de reflexión/introspección:
   - no nos sirve para explorar nada de dart
   - solamente de nuestras estructuras concretadas por nosotros
- una herramienta de scripting:
   - no es un lenguaje full-equiped
   - solamente nos permite coger, dejar y ejecutar

Para hacer reflexión:

- tendríamos que tirar de `dart:mirrors` que pierde compatibilidad con Flutter
- tendríamos que lidiar con otra API más, incorporarla como dependencia, etc.

Para hacer scripting:

- tendríamos que tirar de un parser
- tendríamos que impactar la performance con parsing en runtime
- tendríamos que:
   - o tener bridges, que si no hay `dart:mirrors` no es posible
   - o usar otra historieta que corra en paralelo, como creo que promete `quickjs` o `esprima` o otros varios.
   - o empezar desde aquí: un par de functional trees.

La reflexión es tentadora, pero si no hay compatibilidad con flutter, no tiene sentido, porque flutter es la razón gorda de dart.

Y el scripting es una batalla épica que probablemente acabaría perdiendo porque es muy vasto, y probablemente haya algo pero todavía no hemos dado con ello, porque lo que dicen que hay, tal como lo han explicado que funciona, no es lo mismo, no interesa tanto. No interesa instalar un engine de js externo si luego no deja acceder a absolutamente todas las cosas de Dart. Y en este paso, cae la reflection, que está vetada.

Así que en resumidas cuentas, no es una necesidad, pero sí es interesante hacer dinámicas estas 3 operaciones:

- coger
- dejar
- ejecutar

Y las otras soluciones son muy desproporcionadas.

Esta clase resuelve eso.

### Test de FunctionalTree

El test es este:

```dart
#!/usr/bin/env dart

import './FunctionalTree.dart';

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
```

### Implementación final de FunctionalTree

La implementación actual es esta, que la dejamos en `FunctionalTree.dart`:

```dart
class TreeWrapper {

  final Map _root;

  TreeWrapper(this._root);

}

class AccessibleTree extends TreeWrapper {

  AccessibleTree(super.root);

  dynamic get(List path) {
    Map current = _root;
    int i = 0;
    for (i = 0; i < path.length; i++) {
      Object key = path[i];
      if (!current.containsKey(key)) {
        return null;
      }
      var value = current[key];
      if (i == path.length - 1) {
        if (value is Map) {
          return FunctionalTree(value);
        }
        return value;
      }
      if (value is! Map) {
        return null;
      }
      current = value;
    }
    return null;
  }

  void set(List path, dynamic value) {
    Map current = _root;
    int i = 0;
    for (i = 0; i < path.length - 1; i++) {
      Object key = path[i];
      if (!current.containsKey(key) || current[key] is! Map) {
        current[key] = {};
      }
      current = current[key];
    }
    Object lastKey = path[path.length - 1];
    current[lastKey] = value;
  }

  void init(List path, dynamic value) {
    Map current = _root;
    int i = 0;
    for (i = 0; i < path.length - 1; i++) {
      Object key = path[i];
      if (!current.containsKey(key) || current[key] is! Map) {
        current[key] = {};
      }
      current = current[key];
    }
    Object lastKey = path[path.length - 1];
    if (!current.containsKey(lastKey)) {
      current[lastKey] = value;
    }
  }

  void delete(List path) {
    Map current = _root;
    int i = 0;
    for (i = 0; i < path.length - 1; i++) {
      Object key = path[i];
      if (!current.containsKey(key)) {
        return;
      }
      var value = current[key];
      if (value is! Map) {
        return;
      }
      current = value;
    }
    Object lastKey = path[path.length - 1];
    current.remove(lastKey);
  }

  bool has(List path) {
    Map current = _root;
    int i = 0;
    for (i = 0; i < path.length; i++) {
      Object key = path[i];
      if (!current.containsKey(key)) {
        return false;
      }
      var value = current[key];
      if (i == path.length - 1) {
        return true;
      }
      if (value is! Map) {
        return false;
      }
      current = value;
    }
    return false;
  }

  dynamic list(List path) {
    var value = get(path);
    if (value is FunctionalTree) {
      return value._root.keys.toList();
    }
    if (value is Map) {
      return value.keys.toList();
    }
    return null;
  }

}

class FunctionalTree extends AccessibleTree {

  FunctionalTree(super.root);

  dynamic operator [](Object key) {
    var value = _root[key];
    if (value is Map) {
      return FunctionalTree(value);
    }
    return value;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) {
    String name = invocation.memberName.toString();
    name = name.substring(8, name.length - 2);
    if (invocation.isGetter) {
      var value = _root[name];
      if (value is Map) {
        return FunctionalTree(value);
      }
      return value;
    }
    if (invocation.isMethod) {
      var callback = _root[name];

      if (callback is Function) {
        return Function.apply(callback, invocation.positionalArguments);
      }
    }
    return super.noSuchMethod(invocation);
  }

}
```

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

