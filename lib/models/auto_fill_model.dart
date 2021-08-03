import 'dart:convert';

List<AutoCompleteModel> autoCompleteModelFromJson(String str) =>
    List<AutoCompleteModel>.from(
        json.decode(str).map((x) => AutoCompleteModel.fromJson(x)));

String autoCompleteModelToJson(List<AutoCompleteModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AutoCompleteModel {
  AutoCompleteModel({
    this.word,
    this.score,
    this.numSyllables,
  });

  String word;
  int score;
  int numSyllables;

  factory AutoCompleteModel.fromJson(Map<String, dynamic> json) =>
      AutoCompleteModel(
        word: json["word"],
        score: json["score"],
        numSyllables: json["numSyllables"],
      );

  Map<String, dynamic> toJson() => {
        "word": word,
        "score": score,
        "numSyllables": numSyllables,
      };
}
