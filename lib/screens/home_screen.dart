import 'package:flutter/material.dart';
import 'package:tshorts/utils/tts_service.dart';
import 'package:tshorts/utils/subtitle_image_generator.dart';
import 'package:tshorts/utils/video_generator.dart';
import 'dart:io';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<void> createShorts(BuildContext context) async {
    const String text = "세상에 없던 텍스트 쇼츠, TShorts로 시작하세요.";

    final tts = TTSService();
    final subtitleGen = SubtitleImageGenerator();
    final videoGen = VideoGenerator();

    await tts.initTTS();

    final tempDir = Directory.systemTemp;
    final audioPath = '${tempDir.path}/voice.mp3';
    final bgmPath = '${tempDir.path}/bgm.mp3'; // 미리 준비한 배경 음악 파일
    final bgPath = '${tempDir.path}/bg.png';   // 미리 준비한 배경 이미지 파일

    await tts.saveToFile(text, audioPath);
    final subtitlePath = await subtitleGen.createSubtitleImage(text);
    final outputPath = await videoGen.generateVideo(
      backgroundImagePath: bgPath,
      subtitleImagePath: subtitlePath,
      ttsAudioPath: audioPath,
      bgmAudioPath: bgmPath,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('영상 생성 완료! 저장 위치: $outputPath')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome TShorts. This is New World.',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => createShorts(context),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent),
              child: const Text('Create Shorts'),
            ),
          ],
        ),
      ),
    );
  }
}
