import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class SubtitleImageGenerator {
  Future<String> createSubtitleImage(String text) async {
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    final paint = Paint()..color = Colors.transparent;

    const width = 720.0;
    const height = 1280.0;

    // 배경
    canvas.drawRect(Rect.fromLTWH(0, 0, width, height), paint);

    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 40,
          fontWeight: FontWeight.bold,
        ),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    textPainter.layout(
      minWidth: 0,
      maxWidth: width - 40,
    );

    textPainter.paint(
      canvas,
      Offset((width - textPainter.width) / 2, height / 2 - textPainter.height / 2),
    );

    final picture = recorder.endRecording();
    final img = await picture.toImage(width.toInt(), height.toInt());
    final byteData = await img.toByteData(format: ui.ImageByteFormat.png);

    final directory = await getTemporaryDirectory();
    final filePath = '${directory.path}/subtitle.png';
    final file = File(filePath);
    await file.writeAsBytes(byteData!.buffer.asUint8List());

    return filePath;
  }
}
