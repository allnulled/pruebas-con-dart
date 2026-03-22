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