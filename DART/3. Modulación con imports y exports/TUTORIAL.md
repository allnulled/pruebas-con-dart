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