import "./boot/BojFunctionalSwitcher.dart";
import "./domains/utils/getRandomInteger.dart";
import "../BojFramework.dart";

class BojUtils {

  final BojFramework boj;
  final BojFunctionalSwitcher functions = BojFunctionalSwitcher(tree: {
    "getRandomInteger": getRandomInteger
  }, errorHandler: () {});

  BojUtils(this.boj);

  String getVersion() {
    return boj.version;
  }

}