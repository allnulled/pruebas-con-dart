import 'package:flutter/material.dart';
import 'BojStatelessWidget.dart';

class BojBox extends StatelessWidget {
  final String title;

  BojBox({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.zero,
      child: ListTile(title: Padding(
        padding: EdgeInsets.zero,
          child: Text(title)
        )
      ),
    );
  }
}
