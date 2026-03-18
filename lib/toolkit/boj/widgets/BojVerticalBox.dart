import 'package:flutter/material.dart';
import '../BojFramework.dart';

class BojVerticalBox extends StatelessWidget {

  final String title;

  const BojVerticalBox({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title)
      ],
    );
  }

}