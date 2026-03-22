class TreeWrapper {

  final Map _root;

  TreeWrapper(this._root);

}

class AccessibleTree extends TreeWrapper {

  AccessibleTree(super.root);

  dynamic get(List path) {
    Map current = _root;
    int i = 0;
    for (i = 0; i < path.length; i++) {
      Object key = path[i];
      if (!current.containsKey(key)) {
        return null;
      }
      var value = current[key];
      if (i == path.length - 1) {
        if (value is Map) {
          return FunctionalTree(value);
        }
        return value;
      }
      if (value is! Map) {
        return null;
      }
      current = value;
    }
    return null;
  }

  void set(List path, dynamic value) {
    Map current = _root;
    int i = 0;
    for (i = 0; i < path.length - 1; i++) {
      Object key = path[i];
      if (!current.containsKey(key) || current[key] is! Map) {
        current[key] = {};
      }
      current = current[key];
    }
    Object lastKey = path[path.length - 1];
    current[lastKey] = value;
  }

  void init(List path, dynamic value) {
    Map current = _root;
    int i = 0;
    for (i = 0; i < path.length - 1; i++) {
      Object key = path[i];
      if (!current.containsKey(key) || current[key] is! Map) {
        current[key] = {};
      }
      current = current[key];
    }
    Object lastKey = path[path.length - 1];
    if (!current.containsKey(lastKey)) {
      current[lastKey] = value;
    }
  }

  void delete(List path) {
    Map current = _root;
    int i = 0;
    for (i = 0; i < path.length - 1; i++) {
      Object key = path[i];
      if (!current.containsKey(key)) {
        return;
      }
      var value = current[key];
      if (value is! Map) {
        return;
      }
      current = value;
    }
    Object lastKey = path[path.length - 1];
    current.remove(lastKey);
  }

  bool has(List path) {
    Map current = _root;
    int i = 0;
    for (i = 0; i < path.length; i++) {
      Object key = path[i];
      if (!current.containsKey(key)) {
        return false;
      }
      var value = current[key];
      if (i == path.length - 1) {
        return true;
      }
      if (value is! Map) {
        return false;
      }
      current = value;
    }
    return false;
  }

  dynamic list(List path) {
    var value = get(path);
    if (value is FunctionalTree) {
      return value._root.keys.toList();
    }
    if (value is Map) {
      return value.keys.toList();
    }
    return null;
  }

}

class FunctionalTree extends AccessibleTree {

  FunctionalTree(super.root);

  dynamic operator [](Object key) {
    var value = _root[key];
    if (value is Map) {
      return FunctionalTree(value);
    }
    return value;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) {
    String name = invocation.memberName.toString();
    name = name.substring(8, name.length - 2);
    if (invocation.isGetter) {
      var value = _root[name];
      if (value is Map) {
        return FunctionalTree(value);
      }
      return value;
    }
    if (invocation.isMethod) {
      var callback = _root[name];

      if (callback is Function) {
        return Function.apply(callback, invocation.positionalArguments);
      }
    }
    return super.noSuchMethod(invocation);
  }

}