import './BojDynamicParameters.dart';

class BojFunctionalSwitcher {
  
  final Map<String, dynamic> tree;
  final Function errorHandler;

  BojFunctionalSwitcher({
    required this.tree,
    required this.errorHandler,
  });

  dynamic run(List<String> route, Map<String, dynamic> args) {
    dynamic pivot = tree;
    for (int index = 0; index < route.length; index++) {
      String property = route[index];
      if (pivot is! Map) {
        return errorHandler(property, index, pivot);
      }
      if (!pivot.containsKey(property)) {
        return errorHandler(property, index, pivot);
      }
      pivot = pivot[property];
    }
    if (pivot is Function) {
      return pivot(BojDynamicParameters(args));
    }
    return errorHandler(null, route.length, pivot);
  }

}