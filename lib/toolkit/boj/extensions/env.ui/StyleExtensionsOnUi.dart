import 'package:flutter/material.dart';

extension WidgetStyleHelpers on Widget {
  
  Widget paddingAll(double value) {
    return Padding(padding: EdgeInsets.all(value), child: this);
  }

  Widget paddingSymmetric({double horizontal = 0, double vertical = 0}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
      child: this,
    );
  }

  Widget backgroundColor(Color color) {
    return Container(color: color, child: this);
  }

  Widget paddingOnly({
    double left = 0,
    double right = 0,
    double top = 0,
    double bottom = 0,
  }) {
    return Padding(
      padding: EdgeInsets.only(
        left: left,
        right: right,
        top: top,
        bottom: bottom,
      ),
      child: this,
    );
  }

  Widget background(Color color) {
    return Container(color: color, child: this);
  }

  Widget border({
    Color color = Colors.black,
    double width = 1,
    double radius = 0,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: color, width: width),
        borderRadius: BorderRadius.circular(radius),
      ),
      child: this,
    );
  }
}

extension TextStyleHelpers on Text {
  
  Text fontSize(double size) {
    return Text(
      data ?? "",
      style: (style ?? const TextStyle()).copyWith(fontSize: size),
    );
  }

  Text color(Color color) {
    return Text(
      data ?? "",
      style: (style ?? const TextStyle()).copyWith(color: color),
    );
  }

  Text weight(FontWeight weight) {
    return Text(
      data ?? "",
      style: (style ?? const TextStyle()).copyWith(fontWeight: weight),
    );
  }

}
