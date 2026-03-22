class Platformer {

  static const bool hasIo = bool.fromEnvironment("dart.library.io");
  static const bool hasHtml = bool.fromEnvironment("dart.library.html");
  static const bool hasUi = bool.fromEnvironment("dart.library.ui");
  static const bool isWeb = hasHtml;
  static const bool isOs = hasIo;
  static const bool isNativeGui = hasUi;
  static const bool isGui = hasHtml || hasUi;
  static const Map<String,List<String>> allImplications = {
    "none": [],
    "any": ["any","os","cli","server","gui","nativeGui","web"],
    "os": ["any","os"],
    "cli": ["any","os","cli"],
    "server": ["any","os","server"],
    "gui": ["any","gui"],
    "nativeGui": ["any","os","gui","nativeGui"],
    "web": ["any","gui","web"],
  };
  static List<String> getImplicationsFor(String env) {
    if(!allImplications.containsKey(env)) {
      throw Exception("Environment id «$env» not identified on «Platformer.getImplicationsFor»");
    }
    List<String> carriedImplications = allImplications[env]!;
    return carriedImplications;
  }
  static List<String> getImplications() {
    return getImplicationsFor(Platformer.global.env);
  }
  String env = hasIo ? "cli" : hasHtml ? "web" : hasUi ? "nativeGui" : "none";
  void specify(String env) {
    if(!["cli","server"].contains(env)) {
      throw Exception("Environment id «$env» not identified because there is only «cli» and «server» available on «Platformer.specify»");
    }
    env = env;
  }
  Platformer(String? env) {
    if(env != null) {
      this.env = env;
    }
  }
  static Platformer global = Platformer(null);
}