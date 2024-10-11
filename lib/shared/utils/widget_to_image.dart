import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

Future<Uint8List?> exportWidgetAsImage(GlobalKey widgetKey) async {
  try {
    RenderRepaintBoundary boundary =
        widgetKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage(pixelRatio: 3.0);
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData!.buffer.asUint8List();

    await ImageGallerySaver.saveImage(pngBytes, quality: 100, name: "my_image");
    print("Image saved to gallery.");
    return pngBytes;
  } catch (e) {
    print(e.toString());
    return null;
  }
}

Future<Uint8List> _capturePng(GlobalKey widgetKey) async {
  RenderRepaintBoundary boundary =
      widgetKey.currentContext!.findRenderObject() as RenderRepaintBoundary;

  if (boundary.debugNeedsPaint) {
    print("Waiting for boundary to be painted.");
    await Future.delayed(const Duration(milliseconds: 20));
    return _capturePng(widgetKey);
  }

  var image = await boundary.toImage();
  var byteData = await image.toByteData(format: ImageByteFormat.png);
  return byteData!.buffer.asUint8List();
}

void printPngBytes(GlobalKey widgetKey) async {
  var pngBytes = await _capturePng(widgetKey);
  await ImageGallerySaver.saveImage(pngBytes, quality: 100, name: "my_image");
  print("Image Saved");
}
