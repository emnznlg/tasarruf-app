import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter_svg/flutter_svg.dart';

Future<void> convertSvgToPng() async {
  final svgString = await File('assets/icon/icon.svg').readAsString();
  final pictureInfo = await vg.loadPicture(SvgStringLoader(svgString), null);

  final image = await pictureInfo.picture.toImage(512, 512);
  final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
  final buffer = byteData!.buffer.asUint8List();

  await File('assets/icon/icon.png').writeAsBytes(buffer);
}
