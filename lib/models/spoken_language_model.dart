import 'dart:convert';

class SpokenLanguageModel {
  SpokenLanguageModel({
    this.iso6391,
    this.name,
  });

  final String iso6391;
  final String name;

  factory SpokenLanguageModel.fromJson(String str) =>
      SpokenLanguageModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SpokenLanguageModel.fromMap(Map<String, dynamic> json) =>
      SpokenLanguageModel(
        iso6391: json["iso_639_1"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "iso_639_1": iso6391,
        "name": name,
      };
}
