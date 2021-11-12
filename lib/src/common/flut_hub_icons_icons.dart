// Place fonts/flut_hub_icons.ttf in your fonts/ directory and
// add the following to your pubspec.yaml
// flutter:
//   fonts:
//    - family: flut_hub_icons
//      fonts:
//       - asset: fonts/flut_hub_icons.ttf
import 'package:flutter/widgets.dart';

class FlutHubIcons {
  FlutHubIcons._();

  static const String _fontFamily = 'flut_hub_icons';

  static const IconData more = IconData(0xe903, fontFamily: _fontFamily);
  static const IconData leftArrow = IconData(0xe902, fontFamily: _fontFamily);
  static const IconData githubLogoFace = IconData(0xe900, fontFamily: _fontFamily);
  static const IconData upArrow = IconData(0xe901, fontFamily: _fontFamily);
}
