import 'package:flutter/material.dart';
import '../models/template_model.dart';
import 'template_select_page.dart';
import '../utils/video_generator.dart';

class EditPage extends StatefulWidget {
  const EditPage({super.key});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  VideoTemplate? selectedTemplate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('영상 편집')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () async {
                final template = await Navigator.push<VideoTemplate>(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TemplateSelectPage(
                      onTemplateSelected: (template) =>
                          Navigator.pop(context, template),
                    ),
                  ),
                );

                if (template != null) {
                  setState(() => selectedTemplate = template);
                }
              },
              child: const Text('스타일 템플릿 선택하기'),
            ),
            const SizedBox(height: 16),
            if (selectedTemplate != null) ...[
              Text('선택한 스타일: ${selectedTemplate!.name}'),
              Image.asset(
                'assets/templates/${selectedTemplate!.defaultBackground}',
                height: 160,
              ),
              Text('자막 스타일: ${selectedTemplate!.ttsStyle}'),
              Text('자막 위치: ${selectedTemplate!.subtitlePosition}'),
              Text('음악: ${selectedTemplate!.defaultMusic}'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => generateVideo(selectedTemplate!),
                child: const Text('영상 생성하기'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
