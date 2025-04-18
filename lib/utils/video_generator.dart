import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class VideoGenerator {
  Future<String> generateVideo({
    required String backgroundImagePath,
    required String subtitleImagePath,
    required String ttsAudioPath,
    required String bgmAudioPath,
  }) async {
    final directory = await getTemporaryDirectory();
    final outputPath = '${directory.path}/output.mp4';

    final command = '''
      -loop 1 -i $backgroundImagePath 
      -i $subtitleImagePath 
      -i $ttsAudioPath 
      -i $bgmAudioPath 
      -filter_complex "[0:v][1:v] overlay=0:0:enable='between(t,0,20)'" 
      -map 2:a -map 3:a -shortest 
      -c:v libx264 -c:a aac -strict experimental 
      -y $outputPath
    ''';

    await FFmpegKit.execute(command);
    return outputPath;
  }
}
