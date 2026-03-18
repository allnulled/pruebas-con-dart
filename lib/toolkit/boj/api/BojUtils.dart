import "../BojFramework.dart";

class BojUtils {

  final BojFramework boj;

  BojUtils(BojFramework this.boj);

  String getVersion() {
    return this.boj.version;
  }

}