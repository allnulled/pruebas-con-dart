Lo que dice en la documentación oficial es:

> A Javascript engine to use with flutter. Now it is using QuickJS on Android through Dart ffi and JavascriptCore on IOS also through dart-ffi. The Javascript runtimes runs synchronously through the dart ffi. So now you can run javascript code as a native citzen inside yours Flutter Mobile Apps (Android, IOS, Windows, Linux and MacOS are all supported).

Visto en:

- [https://pub.dev/packages/flutter_js](https://pub.dev/packages/flutter_js)

A continuación se explican los pasos. Pero antes, vamos a exponer la conclusión que hemos extraído.

## Conclusión de usar flutter_js que es la opción más normal para embeder JavaScript en Dart

Vamos a apuntar los límites de la implementación final de JS en apps Flutter:

- (especulación) No se puede acceder a clases
- (especulación) No se puede acceder a propiedades de clase
- (especulación) No se puede acceder a métodos de clase
- (especulación) Solo se puede acceder a propiedades de instancias de Map y List
- (especulación) Sí se puede usar el paquete de Math
- (especulación) Sí se pueden usar los métodos prototype de String, Number, Array, Object
- (especulación) LUZ: si implementas tu API en formato Map y Function???

## Paso 1. Añade flutter_js en pubspec.yaml

```yaml
dependencies:
  flutter_js: 0.1.0+0
```


