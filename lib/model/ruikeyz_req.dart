import 'dart:convert';

RuikeyReqBaseModel ruikeyReqBaseModelFromJson(String str) =>
    RuikeyReqBaseModel.fromJson(json.decode(str));

String ruikeyReqBaseModelToJson(RuikeyReqBaseModel data) =>
    json.encode(data.toJson());

class RuikeyReqBaseModel {
  RuikeyReqBaseModel({
    this.businessid,
    required this.encrypttypeid,
    required this.platformusercode,
    required this.goodscode,
    this.inisoftkey,
    this.timestamp,
    this.data,
    this.sign,
    this.platformtypeid,
  });

  int? businessid;
  int encrypttypeid;
  String platformusercode;
  String goodscode;
  String? inisoftkey;
  int? timestamp;
  String? data;
  String? sign;
  int? platformtypeid;

  factory RuikeyReqBaseModel.fromJson(Map<String, dynamic> json) =>
      RuikeyReqBaseModel(
        businessid: json["businessid"],
        encrypttypeid: json["encrypttypeid"],
        platformusercode: json["platformusercode"],
        goodscode: json["goodscode"],
        inisoftkey: json["inisoftkey"],
        timestamp: json["timestamp"],
        data: json["data"],
        sign: json["sign"],
        platformtypeid: json["platformtypeid"],
      );

  Map<String, dynamic> toJson() => {
        "businessid": businessid,
        "encrypttypeid": encrypttypeid,
        "platformusercode": platformusercode,
        "goodscode": goodscode,
        "inisoftkey": inisoftkey,
        "timestamp": timestamp,
        "data": data,
        "sign": sign,
        'platformtypeid': platformtypeid,
      };
}

RuikeyReqDataModel ruikeyReqDataModelFromJson(String str) =>
    RuikeyReqDataModel.fromJson(json.decode(str));

String ruikeyReqDataModelToJson(RuikeyReqDataModel data) =>
    json.encode(data.toJson());

class RuikeyReqDataModel {
  RuikeyReqDataModel({
    required this.requestflag,
    required this.maccode,
    required this.timestamp,
    required this.cardnum,
  });

  String requestflag;
  String maccode;
  String timestamp;
  String cardnum;

  factory RuikeyReqDataModel.fromJson(Map<String, dynamic> json) =>
      RuikeyReqDataModel(
        requestflag: json["requestflag"],
        maccode: json["maccode"],
        timestamp: json["timestamp"],
        cardnum: json["cardnum"],
      );

  Map<String, dynamic> toJson() => {
        "requestflag": requestflag,
        "maccode": maccode,
        "timestamp": timestamp,
        "cardnum": cardnum,
      };
}
