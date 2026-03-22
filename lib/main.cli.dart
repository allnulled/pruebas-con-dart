import "dart:convert";

import "usables/Platformer.dart";
import "usables/Inspector.dart";
import "usables/ProgramArguments.dart";
import "usables/FunctionalTree.dart";

import "progressables/Scripter.dart";

void main() {
  dynamic output1 = Scripter.ast(
    """
      /* Ahora le puedo poner comentarios y no pasa nada? */
      (local.set sayHello = [
        (parameters name age city)
        (print name age city)
        (return (string.concat "Hi, " name "!"))
      ])
      (io.print "Hello" "How are you" "This is a new line")
      (io.print (call sayHello "Carl" 35 "Oklahome"))
      (return message)
    """
  );

  for(int index = 0; index < output1.length; index++) {
    dynamic item = output1[index];
    print(index);
    print(item);
  }
  print(output1[1]);
  print(json.encode(output1));
  
}

/*
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            Text("Hello, from Boj!"),
            boj.widgets.ControlForLine(content: "Whatever"),
          ],
        ),
      ),
    );
  }
}
*/
