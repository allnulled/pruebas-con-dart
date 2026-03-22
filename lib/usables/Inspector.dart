class Inspector {

  Inspector();
  
  /// Inspecciona cualquier objeto, clase, mapa o lista
  void introspect(dynamic value, {int depth = 2, int indent = 0}) {
    final pad = ' ' * indent;
    if (value == null) {
      print('${pad}null');
      return;
    }
    // Listas
    if (value is List) {
      print('${pad}List [');
      if (depth > 0) {
        for (var v in value) {
          introspect(v, depth: depth - 1, indent: indent + 2);
        }
      }
      print('${pad}]');
      return;
    }
    // Mapas
    if (value is Map) {
      print('${pad}Map {');
      if (depth > 0) {
        value.forEach((k, v) {
          print('${pad}  $k:');
          introspect(v, depth: depth - 1, indent: indent + 4);
        });
      }
      print('${pad}}');
      return;
    }
    // Objetos
    try {
      final mirror = value.runtimeType;
      print('${pad}${mirror.toString()} {');
      if (depth > 0) {
        final props = value is Object
            ? value.toString() // fallback
            : value;
        print('${pad}  $props');
      }
      print('${pad}}');
    } catch (e) {
      print('${pad}$value');
    }
  }

  static Inspector global = Inspector();

  static void inspect(Object x) {
    return global.introspect(x);
  }

}