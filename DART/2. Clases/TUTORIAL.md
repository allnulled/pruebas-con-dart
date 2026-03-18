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