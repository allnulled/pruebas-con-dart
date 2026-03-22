import "package:flutter/material.dart";

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  MyApp({super.key});

  late MaterialApp app;

  @override
  Widget build(BuildContext context) {
    app = MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            Text("Hello, from custom app!"),
            Text("Hello, from custom app!"),
            Text("Hello, from custom app!"),
          ],
        ),
      ),
    );
    return app;
  }

}