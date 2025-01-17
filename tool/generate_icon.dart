import 'package:flutter/widgets.dart';
import 'package:tasarruf/src/utils/svg_to_png.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await convertSvgToPng();
  print('Icon generated successfully!');
}
