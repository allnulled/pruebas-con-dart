import "../Platformer.dart";

class Parameters {

}

class Environmentable {
  
  Map commands;

  Environmentable(this.commands);

  void run(Map args, [String? platformerEnv]) {
    List<String> matchableEnvs = Platformer.getImplicationsFor(platformerEnv ?? Platformer.global.env);
    for (int i = 0; i < matchableEnvs.length; i++) {
      String env = matchableEnvs[i];
      if(commands.containsKey(env)) {
        Function callback = commands[env]!;
        Function.apply(callback, [args, matchableEnvs]);
      }
    }
  }

}