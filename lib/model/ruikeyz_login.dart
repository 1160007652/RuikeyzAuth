import 'dart:convert';

RuikeyLoginDataModel ruikeyLoginDataModelFromJson(String str) =>
    RuikeyLoginDataModel.fromJson(json.decode(str));

String ruikeyLoginDataModelToJson(RuikeyLoginDataModel data) =>
    json.encode(data.toJson());

class RuikeyLoginDataModel {
  RuikeyLoginDataModel({
    required this.heartbeatkey,
    required this.token,
    required this.endtime,
    required this.surpluspointvalue,
    required this.currentloginnum,
    required this.priceid,
    required this.pricename,
    required this.roleid,
    required this.rolename,
    required this.maxloginnum,
    required this.ispay,
    required this.jurisdictionlist,
    required this.qq,
    required this.wx,
    required this.alipay,
    required this.tel,
    required this.email,
    required this.remarks,
    required this.requestflag,
    required this.servertimestamp,
  });

  String heartbeatkey;
  String token;
  DateTime endtime;
  int surpluspointvalue;
  int currentloginnum;
  String priceid;
  String pricename;
  String roleid;
  String rolename;
  int maxloginnum;
  int ispay;
  List<dynamic> jurisdictionlist;
  String qq;
  String wx;
  String alipay;
  String tel;
  String email;
  String remarks;
  String requestflag;
  int servertimestamp;

  factory RuikeyLoginDataModel.fromJson(Map<String, dynamic> json) =>
      RuikeyLoginDataModel(
        heartbeatkey: json["heartbeatkey"],
        token: json["token"],
        endtime: DateTime.parse(json["endtime"]),
        surpluspointvalue: json["surpluspointvalue"],
        currentloginnum: json["currentloginnum"],
        priceid: json["priceid"],
        pricename: json["pricename"],
        roleid: json["roleid"],
        rolename: json["rolename"],
        maxloginnum: json["maxloginnum"],
        ispay: json["ispay"],
        jurisdictionlist:
            List<dynamic>.from(json["jurisdictionlist"].map((x) => x)),
        qq: json["qq"],
        wx: json["wx"],
        alipay: json["alipay"],
        tel: json["tel"],
        email: json["email"],
        remarks: json["remarks"],
        requestflag: json["requestflag"],
        servertimestamp: json["servertimestamp"],
      );

  Map<String, dynamic> toJson() => {
        "heartbeatkey": heartbeatkey,
        "token": token,
        "endtime": endtime.toIso8601String(),
        "surpluspointvalue": surpluspointvalue,
        "currentloginnum": currentloginnum,
        "priceid": priceid,
        "pricename": pricename,
        "roleid": roleid,
        "rolename": rolename,
        "maxloginnum": maxloginnum,
        "ispay": ispay,
        "jurisdictionlist": List<dynamic>.from(jurisdictionlist.map((x) => x)),
        "qq": qq,
        "wx": wx,
        "alipay": alipay,
        "tel": tel,
        "email": email,
        "remarks": remarks,
        "requestflag": requestflag,
        "servertimestamp": servertimestamp,
      };
}
