import "api/BojDebug.dart";
import "api/BojUtils.dart";
import "api/BojCommandLine.dart";
import "api/env.any/BojWidgets.dart"
    if (dart.library.ui) "api/env.ui/BojWidgetsOnUi.dart";
import "api/env.any/BojServer.dart"
    if (dart.library.io) "api/env.os/BojServerOnOs.dart";
import "api/env.any/BojGraphicalUserInterface.dart"
    if (dart.library.ui) "api/env.ui/BojGraphicalUserInterfaceOnUi.dart";
import "api/env.any/BojTheme.dart"
    if (dart.library.ui) "api/env.ui/BojThemeOnUi.dart";

// Exportar extensiones:
export "extensions/env.any/StyleExtensions.dart"
    if (dart.library.ui) "extensions/env.ui/StyleExtensionsOnUi.dart";

class BojFramework {
  final String version = "1.0.0";
  late String environmentId;
  late BojUtils utils;
  late BojDebug debug;
  late BojWidgets widgets;
  late BojGraphicalUserInterface gui;
  late BojCommandLine cli;
  late BojServerInterface server;
  late BojTheme theme;

  BojFramework(this.environmentId) {
    utils = BojUtils(this);
    debug = BojDebug(this);
    cli = BojCommandLine(this);
    server = BojServerInterface(this);
    widgets = BojWidgets(this);
    gui = BojGraphicalUserInterface(this);
    theme = BojTheme(this);
    BojFramework.global ??= this;
  }

  static BojFramework getGlobal({String environmentId = "cli"}) {
    if (BojFramework.global != null) {
      return BojFramework.global as BojFramework;
    }
    return BojFramework(environmentId);
  }

  static BojFramework? global;
}
