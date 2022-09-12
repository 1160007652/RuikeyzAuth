import 'dart:convert';

RuikeyReturnDataModel ruikeyReturnDataModelFromJson(String str) =>
    RuikeyReturnDataModel.fromJson(json.decode(str));

String ruikeyReturnDataModelToJson(RuikeyReturnDataModel data) =>
    json.encode(data.toJson());

class RuikeyReturnDataModel {
  RuikeyReturnDataModel({
    required this.code,
    required this.msg,
    required this.data,
  });

  int code;
  String msg;
  String data;

  factory RuikeyReturnDataModel.fromJson(Map<String, dynamic> json) =>
      RuikeyReturnDataModel(
        code: json["code"],
        msg: json["msg"],
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "msg": msg,
        "data": data,
      };
}
