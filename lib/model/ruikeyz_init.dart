import 'dart:convert';

RuikeyInitDataModel ruikeyInitDataModelFromJson(String str) =>
    RuikeyInitDataModel.fromJson(json.decode(str));

String ruikeyInitDataModelToJson(RuikeyInitDataModel data) =>
    json.encode(data.toJson());

class RuikeyInitDataModel {
  RuikeyInitDataModel({
    required this.inisoftkey,
    required this.softinfo,
    required this.softpricelist,
    required this.requestflag,
    required this.servertimestamp,
  });

  String inisoftkey;
  Softinfo softinfo;
  List<Softpricelist> softpricelist;
  String requestflag;
  int servertimestamp;

  factory RuikeyInitDataModel.fromJson(Map<String, dynamic> json) =>
      RuikeyInitDataModel(
        inisoftkey: json["inisoftkey"],
        softinfo: Softinfo.fromJson(json["softinfo"]),
        softpricelist: List<Softpricelist>.from(
            json["softpricelist"].map((x) => Softpricelist.fromJson(x))),
        requestflag: json["requestflag"],
        servertimestamp: json["servertimestamp"],
      );

  Map<String, dynamic> toJson() => {
        "inisoftkey": inisoftkey,
        "softinfo": softinfo.toJson(),
        "softpricelist":
            List<dynamic>.from(softpricelist.map((x) => x.toJson())),
        "requestflag": requestflag,
        "servertimestamp": servertimestamp,
      };
}

class Softinfo {
  Softinfo({
    required this.softname,
    required this.consultwebsite,
    required this.consultqq,
    required this.consultwx,
    required this.consulttel,
    required this.opentestcount,
    required this.opentestday,
    required this.logourl,
    required this.notice,
    required this.basedata,
    required this.newversionnum,
    required this.networkdiskurl,
    required this.diskpwd,
    required this.isforceupd,
    required this.logintypeid,
    required this.consumetypeid,
    required this.isoutsoftuser,
    required this.isbinding,
    required this.deductionconsumevalue,
    required this.maxloginnum,
  });

  String softname;
  String consultwebsite;
  String consultqq;
  String consultwx;
  String consulttel;
  int opentestcount;
  int opentestday;
  String logourl;
  String notice;
  String basedata;
  String newversionnum;
  String networkdiskurl;
  String diskpwd;
  int isforceupd;
  int logintypeid;
  int consumetypeid;
  int isoutsoftuser;
  int isbinding;
  int deductionconsumevalue;
  int maxloginnum;

  factory Softinfo.fromJson(Map<String, dynamic> json) => Softinfo(
        softname: json["softname"],
        consultwebsite: json["consultwebsite"],
        consultqq: json["consultqq"],
        consultwx: json["consultwx"],
        consulttel: json["consulttel"],
        opentestcount: json["opentestcount"],
        opentestday: json["opentestday"],
        logourl: json["logourl"],
        notice: json["notice"],
        basedata: json["basedata"],
        newversionnum: json["newversionnum"],
        networkdiskurl: json["networkdiskurl"],
        diskpwd: json["diskpwd"],
        isforceupd: json["isforceupd"],
        logintypeid: json["logintypeid"],
        consumetypeid: json["consumetypeid"],
        isoutsoftuser: json["isoutsoftuser"],
        isbinding: json["isbinding"],
        deductionconsumevalue: json["deductionconsumevalue"],
        maxloginnum: json["maxloginnum"],
      );

  Map<String, dynamic> toJson() => {
        "softname": softname,
        "consultwebsite": consultwebsite,
        "consultqq": consultqq,
        "consultwx": consultwx,
        "consulttel": consulttel,
        "opentestcount": opentestcount,
        "opentestday": opentestday,
        "logourl": logourl,
        "notice": notice,
        "basedata": basedata,
        "newversionnum": newversionnum,
        "networkdiskurl": networkdiskurl,
        "diskpwd": diskpwd,
        "isforceupd": isforceupd,
        "logintypeid": logintypeid,
        "consumetypeid": consumetypeid,
        "isoutsoftuser": isoutsoftuser,
        "isbinding": isbinding,
        "deductionconsumevalue": deductionconsumevalue,
        "maxloginnum": maxloginnum,
      };
}

class Softpricelist {
  Softpricelist({
    required this.priceid,
    required this.pricetypename,
    required this.consumevalue,
    required this.consumeunit,
    required this.price,
    required this.roleid,
    required this.rolename,
    required this.maxLoginNum,
  });

  String priceid;
  String pricetypename;
  int consumevalue;
  String consumeunit;
  double price;
  String roleid;
  String rolename;
  int maxLoginNum;

  factory Softpricelist.fromJson(Map<String, dynamic> json) => Softpricelist(
        priceid: json["priceid"],
        pricetypename: json["pricetypename"],
        consumevalue: json["consumevalue"],
        consumeunit: json["consumeunit"],
        price: json["price"],
        roleid: json["roleid"],
        rolename: json["rolename"],
        maxLoginNum: json["maxLoginNum"],
      );

  Map<String, dynamic> toJson() => {
        "priceid": priceid,
        "pricetypename": pricetypename,
        "consumevalue": consumevalue,
        "consumeunit": consumeunit,
        "price": price,
        "roleid": roleid,
        "rolename": rolename,
        "maxLoginNum": maxLoginNum,
      };
}
