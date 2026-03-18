export "../../extensions/env.ui/StyleExtensionsOnUi.dart";

import "../../BojFramework.dart";

import "../../widgets/BojBox.dart";
import "../../widgets/BojHorizontalBox.dart";
import "../../widgets/BojVerticalBox.dart";
import "../../widgets/BojStatefulWidget.dart";
import "../../widgets/BojStatelessWidget.dart";
import "../../widgets/BojControlForLine.dart";
import "../../widgets/BojControlForMultiline.dart";

import '../../annotations/Expose.dart';

class BojWidgets {
  final BojFramework boj;

  late Function Box;
  late Function HorizontalBox;
  late Function VerticalBox;
  late Function ControlForLine;
  late Function ControlForMultiline;
  late Function StatefulWidget;
  late Function StatelessWidget;

  BojWidgets(this.boj) {
    Box = BojBox.new;
    ControlForLine = BojControlForLine.new;
    ControlForMultiline = BojControlForMultiline.new;
    HorizontalBox = BojHorizontalBox.new;
    VerticalBox = BojVerticalBox.new;
    StatefulWidget = BojStatefulWidget.new;
    StatelessWidget = BojStatelessWidget.new;
  }

  @Expose("texto", [])
  void hello() {
    print("Hello from BojWidgets.prototype.hello:void");
  }

}
