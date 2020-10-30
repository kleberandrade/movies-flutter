import 'dart:convert';

class ProductionCountryModel {
  ProductionCountryModel({
    this.iso31661,
    this.name,
  });

  final String iso31661;
  final String name;

  factory ProductionCountryModel.fromJson(String str) =>
      ProductionCountryModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductionCountryModel.fromMap(Map<String, dynamic> json) =>
      ProductionCountryModel(
        iso31661: json["iso_3166_1"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "iso_3166_1": iso31661,
        "name": name,
      };
}
