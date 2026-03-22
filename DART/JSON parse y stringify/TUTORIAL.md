Hay alguna forma más, pero:

```dart
import 'dart:convert';

void main() {
  print(json.encode(List.from([1, 2, 3])));
  print(json.encode(List.from(['foo', 'bar', 'dart'])));
  print(json.encode({'a': 1, 'b': 2}));
  print(json.decode('{"a":1,"b":2}'));
}
```