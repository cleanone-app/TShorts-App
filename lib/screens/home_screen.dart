import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import '../models/template_model.dart';
import '../services/video_generator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TemplateModel selectedTemplate = templates[0];

  Future<void> _generateVideo() async {
    final dir = await getTemporaryDirectory();
    final imagePath = '${dir.path}/${selectedTemplate.backgroundImage.split('/').last}';
    final audioPath = '${dir.path}/${selectedTemplate.backgroundMusic.split('/').last}';

    // 복사
    final imageAsset = await rootBundle.load(selectedTemplate.backgroundImage);
    final musicAsset = await rootBundle.load(selectedTemplate.backgroundMusic);
    final imageFile = File(imagePath)..writeAsBytesSync(imageAsset.buffer.asUint8List());
    final audioFile = File(audioPath)..writeAsBytesSync(musicAsset.buffer.asUint8List());

    final videoPath = await VideoGenerator.generateVideo(
      imagePath: imageFile.path,
      audioPath: audioFile.path,
      outputFileName: 'tshorts_${selectedTemplate.id}.mp4',
    );

    await Share.shareXFiles([XFile(videoPath)], text: '${selectedTemplate.name} 스타일 영상 완성!');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TShorts 템플릿 선택'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              '영상 템플릿을 선택하세요',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            DropdownButton<TemplateModel>(
              value: selectedTemplate,
              onChanged: (TemplateModel? newValue) {
                setState(() {
                  selectedTemplate = newValue!;
                });
              },
              items: templates.map<DropdownMenuItem<TemplateModel>>((TemplateModel template) {
                return DropdownMenuItem<TemplateModel>(
                  value: template,
                  child: Text(template.name),
                );
              }).toList(),
            ),
            const SizedBox(height: 40),
            ElevatedButton.icon(
              onPressed: _generateVideo,
              icon: const Icon(Icons.video_call),
              label: const Text('영상 생성하기'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
