import 'package:flutter/material.dart';
import '../BojFramework.dart';

class BojControlForLine extends StatefulWidget {
  final String content;

  const BojControlForLine({super.key, required this.content});

  @override
  State<BojControlForLine> createState() {
    return BojControlForLineState$State();
  }
}

class BojControlForLineState$State extends State<BojControlForLine> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.content);
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(border: InputBorder.none),
    );
  }
}
