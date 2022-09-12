import 'dart:convert';

RuikeyResultModel ruikeyResultModelFromJson(String str) =>
    RuikeyResultModel.fromJson(json.decode(str));

String ruikeyResultModelToJson(RuikeyResultModel data) =>
    json.encode(data.toJson());

class RuikeyResultModel {
  RuikeyResultModel({
    required this.result,
    required this.err,
  });

  int result;
  String err;

  factory RuikeyResultModel.fromJson(Map<String, dynamic> json) =>
      RuikeyResultModel(
        result: json["Result"],
        err: json["Err"],
      );

  Map<String, dynamic> toJson() => {
        "Result": result,
        "Err": err,
      };
}
