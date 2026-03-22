

```dart
class FormatException implements Exception {
  final String message;
  const FormatException([this.message = ""]);
  String toString() => "FormatException: $message";
}
```