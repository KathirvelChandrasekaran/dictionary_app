import 'dart:convert';

class SupabaseResponse {
  String createdBy;
  String word;
  String meanaing;
  String audioURL;
  String phoenetics;
  String partsOfSpeech;
  SupabaseResponse({
    this.createdBy,
    this.word,
    this.meanaing,
    this.audioURL,
    this.phoenetics,
    this.partsOfSpeech,
  });

  Map<String, dynamic> toMap() {
    return {
      'createdBy': createdBy,
      'word': word,
      'meanaing': meanaing,
      'audioURL': audioURL,
      'phoenetics': phoenetics,
      'partsOfSpeech': partsOfSpeech,
    };
  }

  factory SupabaseResponse.fromMap(Map<String, dynamic> map) {
    return SupabaseResponse(
      createdBy: map['createdBy'],
      word: map['word'],
      meanaing: map['meanaing'],
      audioURL: map['audioURL'],
      phoenetics: map['phoenetics'],
      partsOfSpeech: map['partsOfSpeech'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SupabaseResponse.fromJson(String source) =>
      SupabaseResponse.fromMap(json.decode(source));
}
