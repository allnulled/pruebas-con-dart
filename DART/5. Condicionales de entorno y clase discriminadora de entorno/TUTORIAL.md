Hay varios puntos para discriminar entorno en Dart, ya que el mismo código va a correr en diferentes lenguajes y sistemas.

- Condicionales de entorno en los imports
- Condicionales de entorno en el código
- Técnica general

## Condicionales de entorno en los imports

```dart
import 'src/ClasePolientorno.dart'
  if (dart.library.io) 'src/ClaseIo.dart'
  if (dart.library.html) 'src/ClaseWeb.dart';
  if (dart.library.html) 'src/ClaseWeb.dart';
```

Las librerías base de dart son:

```
dart.library.io
dart.library.html
dart.library.js
dart.library.js_interop
dart.library.ffi
dart.library.ui
```

Los entornos donde son compatibles son:

| entorno                | io | html | js | js_interop | ffi | ui |
| ---------------------- | -- | ---- | -- | ---------- | --- | -- |
| Dart VM (CLI/server)   | ✔  |      |    |            | ✔   |    |
| Flutter mobile         | ✔  |      |    |            | ✔   | ✔  |
| Flutter desktop        | ✔  |      |    |            | ✔   | ✔  |
| Flutter web            |    | ✔    | ✔  | ✔          |     |    |
| Browser puro (dart2js) |    | ✔    | ✔  | ✔          |     |    |
| WASM (experimental)    |    |      |    | ✔          |     |    |

Si te fijas, no hay una librería 100% compatible en entorno.

## Condicionales de entorno en el código

En entorno de `io` (no web) puedes:

```dart
import 'dart:io';

Platform.isLinux
Platform.isMacOS
Platform.isWindows
Platform.isAndroid
Platform.isIOS
Platform.isFuchsia

Platform.environment
Platform.operatingSystem
Platform.script
Platform.executable

bool.fromEnvironment("dart.library.io");
bool.fromEnvironment("dart.library.html");
bool.fromEnvironment("dart.library.js");
bool.fromEnvironment("dart.library.js_interop");
bool.fromEnvironment("dart.library.ffi");
bool.fromEnvironment("dart.library.ui");
```

## Técnica general

Hay 3 grandes grupos:

- Sistemas: `dart.library.io`
- Web con gráficos: `dart.library.html`
- Web sin gráficos: `dart.library.js_interop` (incluye WASM)

`ClaseSinGraficos.dart` es común por herencia:

```dart
class ClaseSinGraficos {
  void log(String msg) {
    print(msg);
  }
}
```

`ClaseConGraficos.dart` hereda de la anterior:

```dart
import "ClaseSinGraficos.dart";

class ClaseConGraficos extends ClaseSinGraficos {

  void draw() {
    print("dibujar");
  }

}
```

Y el export en `Clase.dart`:

```dart
export "ClaseSinGraficos.dart"
  if (dart.library.ui) "ClaseConGraficos.dart"
  if (dart.library.html) "ClaseConGraficos.dart";
```

Así:

- solo importas `Clase.dart` pero consigues:
   - `ClaseSinGraficos.dart` → Desktop|Mobile + CLI|Server
   - `ClaseConGraficos.dart` → Desktop|Mobile + Web

## Clase discriminadora de entorno

Al ir dinamizando el código, te va interesar crear `Function` que puedan correr en cualquier entorno.

La clase `Platformer` puede ser de ayuda:

```dart
class Platformer {
  static const bool hasIo = bool.fromEnvironment("dart.library.io");
  static const bool hasHtml = bool.fromEnvironment("dart.library.html");
  static const bool isWeb = hasHtml;
  static const bool isOs = hasIo;
  static const bool isGui = hasHtml || isFlutter;
  static const bool isFlutter = bool.fromEnvironment("dart.library.ui");
}
```