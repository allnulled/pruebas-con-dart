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