import 'dart:convert';

RuikeyPayModel ruikeyPayModelFromJson(String str) =>
    RuikeyPayModel.fromJson(json.decode(str));

String ruikeyPayModelToJson(RuikeyPayModel data) => json.encode(data.toJson());

class RuikeyPayModel {
  RuikeyPayModel({
    required this.result,
    required this.err,
    required this.firstAccept,
    required this.wxCustomer,
    required this.mobile,
    this.gameId,
    this.publishUserId,
    this.popup,
    this.msg,
  });

  dynamic result;
  dynamic err;
  dynamic firstAccept;
  dynamic wxCustomer;
  dynamic mobile;
  dynamic gameId;
  dynamic publishUserId;
  dynamic popup;
  dynamic msg;

  factory RuikeyPayModel.fromJson(Map<String, dynamic> json) => RuikeyPayModel(
        result: json["Result"],
        err: json["Err"],
        firstAccept: json["FirstAccept"],
        wxCustomer: json["WXCustomer"],
        mobile: json["Mobile"],
        gameId: json["GameID"],
        publishUserId: json["PublishUserID"],
        popup: json["Popup"],
        msg: json["Msg"],
      );

  Map<String, dynamic> toJson() => {
        "Result": result,
        "Err": err,
        "FirstAccept": firstAccept,
        "WXCustomer": wxCustomer,
        "Mobile": mobile,
        "GameID": gameId,
        "PublishUserID": publishUserId,
        "Popup": popup,
        "Msg": msg,
      };
}
