// lib/models/template_model.dart

class TemplateModel {
  final String id;
  final String name;
  final String description;
  final String backgroundImageUrl;
  final String backgroundMusicUrl;
  final String ttsVoice;
  final String fontStyle;
  final String aspectRatio; // 예: '9:16', '1:1', '16:9'
  final bool isPremium;

  TemplateModel({
    required this.id,
    required this.name,
    required this.description,
    required this.backgroundImageUrl,
    required this.backgroundMusicUrl,
    required this.ttsVoice,
    required this.fontStyle,
    required this.aspectRatio,
    required this.isPremium,
  });

  // JSON에서 객체로 변환
  factory TemplateModel.fromJson(Map<String, dynamic> json) {
    return TemplateModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      backgroundImageUrl: json['backgroundImageUrl'],
      backgroundMusicUrl: json['backgroundMusicUrl'],
      ttsVoice: json['ttsVoice'],
      fontStyle: json['fontStyle'],
      aspectRatio: json['aspectRatio'],
      isPremium: json['isPremium'] ?? false,
    );
  }

  // 객체를 JSON으로 변환
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'backgroundImageUrl': backgroundImageUrl,
      'backgroundMusicUrl': backgroundMusicUrl,
      'ttsVoice': ttsVoice,
      'fontStyle': fontStyle,
      'aspectRatio': aspectRatio,
      'isPremium': isPremium,
    };
  }
}
