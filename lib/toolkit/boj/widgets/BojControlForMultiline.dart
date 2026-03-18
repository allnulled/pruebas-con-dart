import 'package:flutter/material.dart';
import '../BojFramework.dart';

class BojControlForMultiline extends StatelessWidget {

  final String content;

  const BojControlForMultiline({
    super.key,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(content),
    );
  }

}