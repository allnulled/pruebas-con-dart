En el test, `api` es una instancia de la clase `FunctionalTree.dart` que hemos hecho antes.

El código del test es (obviando otras partes):

```dart
  // @TODO: hacer un benchmarking de acceso directo por Map y acceso por noSuchMethod hack:
  // Benchmark 1 (acceso dinámico)
  DateTime start1 = DateTime.now();

  for(int i = 0; i < 5000; i++) {
    // esta forma usa el hack de noSuchMethod:
    api.domain.specific.command.run({
      "message": "whatever",
      "path": [1,2,300,"what"],
    }, "nativeGui");
  }

  DateTime end1 = DateTime.now();
  Duration diff1 = end1.difference(start1);

  // Benchmark 2 (acceso por Map)

  DateTime start2 = DateTime.now();

  for(int i = 0; i < 5000; i++) {
    // esta forma usa el Map normal:
    api["domain"]["specific"]["command"].run({
      "message": "whatever",
      "path": [1,2,300,"what"],
    }, "nativeGui");
  }

  DateTime end2 = DateTime.now();
  Duration diff2 = end2.difference(start2);

  print("Dynamic access time: " + (diff1.inMicroseconds/1000).toString() + " ms");
  print("Map access time: " + (diff2.inMicroseconds/1000).toString() + " ms");
```

Y las salidas son:

```
Dynamic access time: 785.265 ms
Map access time: 757.342 ms

Dynamic access time: 756.812 ms
Map access time: 643.825 ms

Dynamic access time: 844.323 ms
Map access time: 622.55 ms

Dynamic access time: 813.37 ms
Map access time: 638.085 ms

Dynamic access time: 770.435 ms
Map access time: 704.574 ms

```

Es decir que en el mejor y peor de los casos, la diferencia puede suponer de:

- los resultados desde el compilado en Linux son iguales prácticamente, 600, 800, por ahí.
- un **35% más lento** el método de noSuchMethod que hicimos con la clase `FunctionalTree.dart` comparado con el método normal de Map.
- y en verdad es más porque hemos hecho solo 5 tests
- sería más porque solo hemos accedido a 3 propiedades
   - cuando si lo adoptas como método habitual se multiplicaría.
   - y se multiplicaría por muchas veces.

Sin embargo, para soluciones de scripting, pues mira, queda más bonito.