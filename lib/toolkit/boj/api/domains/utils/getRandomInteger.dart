import '../../boot/BojDynamicParameters.dart';

int getRandomInteger(BojDynamicParameters parameters) {
  return parameters.get("start") + parameters.get("end");
}