import '../BojFramework.dart';

class BojCommandLine {

  final BojFramework boj;
  
  BojCommandLine(this.boj);

  void start(List <String> args) {
    print("Started");
    print(args);
    print(boj);
  }

}