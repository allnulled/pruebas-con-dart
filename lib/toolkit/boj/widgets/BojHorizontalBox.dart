import 'package:flutter/material.dart';
import '../BojFramework.dart';

class BojHorizontalBox extends StatelessWidget {

  final String title;

  const BojHorizontalBox({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title)
      ],
    );
  }

}