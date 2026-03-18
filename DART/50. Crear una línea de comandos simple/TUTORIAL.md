Para crear una línea de comandos simple con Dart, sigue los pasos que se explican a continuación.

- Paso 1. Añadir el ejecutable en el pubspec
- Paso 2. Añadir la clase del ejecutable

## Paso 1. Añadir el ejecutable en el pubspec

En el `pubspec` tiene que aparecer la ruta al ejecutable global:

```yaml
# Esto es para especificar un binario
executables:
  boj: lib/toolkit/boj/binary.dart
```

## Paso 2. Añadir la clase del ejecutable

Podría estar todo en 1 clase, pero en este ejemplo vamos a hacer 1 fichero para el binario, y otro para la clase que gestiona la lógica. Esto es para diferenciar la entrada desde línea de comandos, y la API que gestiona la lógica de la línea de comandos, y poder reaprovecharla a nivel de API también.

Por eso, crearemos 2 ficheros nuevos para gestionar el ejecutable:

- Clase de entrada: `lib/toolkit/boj/binary.dart`
- Clase de lógica: `lib/toolkit/boj/api/BojCommandLineInterface.dart`

### Paso 2.1. Clase de entrada de ejecutable

En el fichero `lib/toolkit/boj/binary.dart` algo como:

```dart
#!/usr/bin/env dart

import 'package:fluttagenda/toolkit/boj/BojFramework.dart';

void main(List<String> args) {
  BojFramework.global.cli.start(args);
}
```

### Paso 2.2. Clase de lógica de ejecutable

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

### Paso 3. Instalar ejecutable

Con esto se instala:

```sh
dart pub global activate --source path .
```

Le hemos dicho que se llama `boj` en el pubspec, así que podremos usarlo desde línea de comandos:

```sh
boj subc1 subc2 --flag --text=whatever --param1 t1 t2 t3 --param2=false --param3=200
```