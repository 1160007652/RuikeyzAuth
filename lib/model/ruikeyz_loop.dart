import 'dart:convert';

RuikeyLoopDataModel ruikeyLoopDataModelFromJson(String str) =>
    RuikeyLoopDataModel.fromJson(json.decode(str));

String ruikeyLoopDataModelToJson(RuikeyLoopDataModel data) =>
    json.encode(data.toJson());

class RuikeyLoopDataModel {
  RuikeyLoopDataModel({
    required this.heartbeatkey,
    required this.endtime,
    required this.surpluspointvalue,
    required this.requestflag,
    required this.servertimestamp,
  });

  String heartbeatkey;
  DateTime endtime;
  int surpluspointvalue;
  String requestflag;
  int servertimestamp;

  factory RuikeyLoopDataModel.fromJson(Map<String, dynamic> json) =>
      RuikeyLoopDataModel(
        heartbeatkey: json["heartbeatkey"],
        endtime: DateTime.parse(json["endtime"]),
        surpluspointvalue: json["surpluspointvalue"],
        requestflag: json["requestflag"],
        servertimestamp: json["servertimestamp"],
      );

  Map<String, dynamic> toJson() => {
        "heartbeatkey": heartbeatkey,
        "endtime": endtime.toIso8601String(),
        "surpluspointvalue": surpluspointvalue,
        "requestflag": requestflag,
        "servertimestamp": servertimestamp,
      };
}
