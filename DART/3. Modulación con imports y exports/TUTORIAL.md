Las técnicas de import y export de módulos de Dart te interesa entenderlas bien porque son la clave de la modulación.

Según qué utilices y cómo, resulta en una cosa u otra.

## Técnicas específicas

En esta sección voy a hacer una lista de las técnicas de uso de **import** y **export** que parecen haber funcionado en los primeros pasos al menos.

### Consejo 1. Usar import con rutas relativas es mejor que con rutas de paquete

Con los `imports` con sus rutas relativas, el entorno del `cli` puede importar los ficheros sin conocer el proyecto.

Aquí se ven las 2 formas de importar:

```dart
// Rutas relativas son así:
import "./ruta/a/fichero.dart";
import "../ruta/a/fichero.dart";
// Rutas de paquete son así:
import "package:mipaquete/ruta/relativa/desde/lib/a/fichero.dart";
```

Si en el `pubspec.yaml#name` tienes `mipaquete`, puedes usarlo como ruta relativa global.

Pero pierdes eso, que un binario satelital pueda importar el framework sin conocer el proyecto.

### Consejo 2. Import + if + pofyfill con late + if + new para clases de entorno UI

Dart permite que tengas programas de línea de comandos, de sistema y de interfaz gráfica.

Este patrón te permite escalar proyectos de forma sistemática para que soporte los 3 casos.

Porque en cada entorno, habrá clases que serán diferentes, porque:

> Hay librerías de UI que en el entorno CLI te darían error. Y Dart simplemente importando 1 package de UI desde un runtime tipo CLI, se va a quejar y a dar problemas.

Pero el compilador requiere que le especifiques 1 interfaz para todo el proyecto igualmente.

El patrón `import + if + polyfill` permite que:

- un mismo proyecto pueda contener clases de cli, de os y de gui.
- el compilador de Dart no se queje.

Cuando digo `polyfill`, digo una clase vacía que cumple con las firmas necesarias para que Dart no se queje.

> En este caso, el polyfill no son clases funcionales, son solo clases de firma.

En este ejemplo se prueba cómo se usa este patrón `import + if + polyfill`:

```dart
// Al importar, las clases comunes se importan normal, pero las específicas de entorno van con un if:
import "./api/BojDebug.dart";
import "./api/BojUtils.dart";
import "./api/BojCommandLineInterface.dart";
// Primero importas el polyfill, y si se cumple con el entorno, el fichero
import "./api/polyfills/BojWidgets.dart" if (dart.library.ui) "api/BojWidgets.dart";
import "./api/polyfills/BojServerInterface.dart" if (dart.library.io) "api/BojServerInterface.dart";
import "./api/polyfills/BojGraphicalUserInterface.dart" if (dart.library.ui) "api/BojGraphicalUserInterface.dart";
import "./api/polyfills/BojTheme.dart" if (dart.library.ui) "api/BojTheme.dart";
```

Luego, en la clase, los acabamos de importar así:

```dart
class BojFramework {

  // late
  late String environmentId;
  late BojUtils utils;
  late BojDebug debug;
  late BojWidgets widgets;
  late BojGraphicalUserInterface gui;
  late BojCommandLineInterface cli;
  late BojServerInterface server;
  late BojTheme theme;

  BojFramework(this.environmentId) {
    utils = BojUtils(this);
    debug = BojDebug(this);
    // if
    if(environmentId == "cli") {
      // new
      cli = BojCommandLineInterface(this);
      server = BojServerInterface(this);
    } else {
      // new
      widgets = BojWidgets(this);
      gui = BojGraphicalUserInterface(this);
      theme = BojTheme(this);
    }
  }

}
```

El patrón es `late + if + new`:

- El `late` permite que inicialicemos las variables más tarde, en el `constructor`
- El `if` se aplica a la condición que nosotros queramos para determinar el entorno
- Los `new` construyen las instancias que requiramos en cada casuística de entorno



