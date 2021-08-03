import 'dart:convert';

ErrorModel errorModelFromJson(String str) =>
    ErrorModel.fromJson(json.decode(str));

String errorModelToJson(ErrorModel data) => json.encode(data.toJson());

class ErrorModel {
  ErrorModel({
    this.title,
    this.message,
    this.resolution,
  });

  String title;
  String message;
  String resolution;

  factory ErrorModel.fromJson(Map<String, dynamic> json) => ErrorModel(
        title: json["title"],
        message: json["message"],
        resolution: json["resolution"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "message": message,
        "resolution": resolution,
      };
}
