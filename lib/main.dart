import 'package:flutter/material.dart';
import 'toolkit/boj/BojFramework.dart';

late BojFramework boj;

void main() {
  boj = BojFramework("gui");
  boj.debug.inspect(boj);
  boj.debug.inspect(boj.utils.getVersion());
  boj.debug.inspect(boj.utils.boj);
  boj.debug.inspect(boj.widgets.Box);
  boj.gui.start([MyApp()]);
}

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
