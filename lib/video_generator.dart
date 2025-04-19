import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:ffmpeg_kit_flutter_full_gpl/ffmpeg_kit.dart';

class VideoGenerator {
  static Future<String> generateVideo({
    required String imagePath,
    required String audioPath,
    required String outputFileName,
  }) async {
    final dir = await getTemporaryDirectory();
    final outputPath = '${dir.path}/$outputFileName';

    final command = [
      '-loop', '1',
      '-i', imagePath,
      '-i', audioPath,
      '-c:v', 'libx264',
      '-tune', 'stillimage',
      '-c:a', 'aac',
      '-b:a', '192k',
      '-pix_fmt', 'yuv420p',
      '-shortest',
      outputPath,
    ].join(' ');

    await FFmpegKit.execute(command);

    return outputPath;
  }
}
