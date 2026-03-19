class BojDynamicParameters {
  
  late Map<String, dynamic> data;

  BojDynamicParameters(this.data);

  bool has(String id) {
    return false;
  }

  bool init(String id, dynamic value) {
    return true;
  }

  dynamic get(String id) {
    print(id);
    return this.data[id];
  }

  bool set(String id, dynamic value) {
    return true;
  }

  bool delete(String id) {
    return true;
  }

}