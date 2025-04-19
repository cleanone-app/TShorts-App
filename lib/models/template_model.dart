class TemplateModel {
  final String id;
  final String name;
  final String backgroundImage;
  final String backgroundMusic;
  final String subtitleStyle;
  final double ttsSpeed;
  final String voice;

  TemplateModel({
    required this.id,
    required this.name,
    required this.backgroundImage,
    required this.backgroundMusic,
    required this.subtitleStyle,
    required this.ttsSpeed,
    required this.voice,
  });
}

final List<TemplateModel> templates = [
  TemplateModel(
    id: 'vlog',
    name: '감성 브이로그',
    backgroundImage: 'assets/images/background1.jpg',
    backgroundMusic: 'assets/music/bgm1.mp3',
    subtitleStyle: 'soft_white',
    ttsSpeed: 1.0,
    voice: 'calm_young_female',
  ),
  TemplateModel(
    id: 'meme',
    name: '밈 스타일',
    backgroundImage: 'assets/images/meme_bg.jpg',
    backgroundMusic: 'assets/music/meme_bgm.mp3',
    subtitleStyle: 'bold_yellow',
    ttsSpeed: 1.2,
    voice: 'funny_male',
  ),
  TemplateModel(
    id: 'news',
    name: '뉴스 리포트',
    backgroundImage: 'assets/images/news_bg.jpg',
    backgroundMusic: 'assets/music/news_bgm.mp3',
    subtitleStyle: 'clean_black',
    ttsSpeed: 0.95,
    voice: 'serious_female',
  ),
  TemplateModel(
    id: 'ad',
    name: '광고 클립',
    backgroundImage: 'assets/images/ad_bg.jpg',
    backgroundMusic: 'assets/music/ad_bgm.mp3',
    subtitleStyle: 'flashy_red',
    ttsSpeed: 1.1,
    voice: 'strong_male',
  ),
];
