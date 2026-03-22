La distinción según ChatGPT es:

- `Exception`: errores esperables / recuperables
- `Error`: fallos de programación / bugs

## Extender la clase Exception

En el caso de `Exception`:

```dart
class MiException implements Exception {
  final String message;
  MiException(this.message);
  @override
  String toString() {
    return "MiException: " + message;
  }
}
void main() {
    throw MiException("archivo no encontrado");
}
```

## Extender la clase Error

En el caso de `Error`:

```dart
class MiError extends Error {
  final String message;
  MiError(this.message);
  @override
  String toString() {
    return "MiError: " + message;
  }
}
```

## Manejar distintos errores en un try-catch

```dart
try {
  throw MiException("fallo");
} on MiException catch (e) {
  print(e);
} on MiError catch (e) {
  print(e);
}
```

**Detalle importante:**

- `Exception` no es una clase, es una interface, por eso: `implements Exception`
- `Error` sí es una clase, por eso: `extends Error`