El patrón idiomático en Dart para jerarquías de errores grandes es crear **una clase base de excepción** y especializarla. Así evitas repetir `message`, `toString`, metadatos, etc.

La base suele implementar Exception.

Ejemplo simple y limpio.

Clase base:

```
class AppException implements Exception {

  final String message;
  final String? code;
  final Object? data;

  AppException(this.message, {this.code, this.data});

  @override
  String toString() {
    String text = "AppException: " + message;
    if(code != null) {
      text = text + " (" + code! + ")";
    }
    return text;
  }

}
```

Ahora las especializaciones **no repiten lógica**.

```
class FileException extends AppException {

  FileException(String message, {Object? data})
      : super(message, code: "FILE_ERROR", data: data);

}
```

```
class NetworkException extends AppException {

  NetworkException(String message, {Object? data})
      : super(message, code: "NETWORK_ERROR", data: data);

}
```

Uso:

```
throw FileException("archivo no encontrado");
```

Captura tipada:

```
try {

  algo();

} on FileException catch(e) {

  print(e.message);

} on NetworkException catch(e) {

  print(e.message);

}
```

También puedes capturar la base:

```
try {

  algo();

} on AppException catch(e) {

  print(e.code);

}
```

---

Un patrón aún más potente es añadir **stacktrace y causa**.

```
class AppException implements Exception {

  final String message;
  final Object? cause;
  final StackTrace? stack;

  AppException(this.message, {this.cause, this.stack});

  @override
  String toString() {
    return "AppException: " + message;
  }

}
```

Cuando capturas:

```
try {

  algo();

} catch(e, st) {

  throw AppException(
    "fallo ejecutando algo",
    cause: e,
    stack: st
  );

}
```

Esto crea **cadenas de errores**, muy útil en librerías.

---

Si quisieras hacer algo más “framework-like”, puedes añadir **un tipo automático basado en el nombre de la clase**, para no repetir strings:

```
class AppException implements Exception {

  final String message;

  AppException(this.message);

  String get type {
    return runtimeType.toString();
  }

  @override
  String toString() {
    return type + ": " + message;
  }

}
```

Entonces:

```
throw FileException("archivo no encontrado");
```

imprime:

```
FileException: archivo no encontrado
```

---

Regla práctica muy usada en Dart:

• librerías → jerarquía basada en `Exception`
• invariantes internas → extender Error
• API pública → lanzar siempre excepciones propias

Así el usuario puede hacer:

```
on AppException
```

y capturar todos tus errores.
