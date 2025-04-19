import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import '../models/template_model.dart';

Future<void> generateVideo(VideoTemplate template) async {
  final background = '/storage/emulated/0/Download/${template.defaultBackground}';
  final music = '/storage/emulated/0/Download/${template.defaultMusic}';
  final output = '/storage/emulated/0/Download/output.mp4';

  final text = '이것은 템플릿 영상입니다';
  final yPos = template.subtitlePosition == 'top' ? '50' : '(h-text_h)-50';

  final command = '''
  -loop 1 -i $background -i $music -filter_complex "
  [0:v]scale=720:1280,format=yuv420p,
  drawtext=text='$text':fontcolor=white:fontsize=48:
  x=(w-text_w)/2:y=$yPos:
  enable='between(t,0,5)',fade=t=in:st=0:d=0.5
  " -shortest -y $output
  ''';

  await FFmpegKit.execute(command);
}
