import 'dart:convert';
import 'package:platform_device_id/platform_device_id.dart';

import 'package:dio/dio.dart';
import 'package:ruikeyz_auth/model/ruikeyz_init.dart';
import 'package:ruikeyz_auth/model/ruikeyz_req.dart';
import 'package:ruikeyz_auth/model/ruikeyz_return.dart';
import 'package:ruikeyz_auth/utils/encrypt_utils.dart';

class AuthProvider {
  static Dio dio = Dio();
  static Map<String, String> crypt = {"slat": "xxxxxx", "key": "xxxxxx"};

  static final RuikeyReqBaseModel dataBase = RuikeyReqBaseModel(
    encrypttypeid: 1,
    platformusercode: "",
    goodscode: "",
    platformtypeid: 1,
  );

  static setDataBase(RuikeyReqBaseModel val) {
    dataBase.encrypttypeid = val.encrypttypeid; //加密
    dataBase.platformusercode = val.platformusercode; // 平台用户Code
    dataBase.goodscode = val.goodscode; // 商品Code
  }

  // 初始化完成后，赋值
  static setInisoftkey(String val) {
    dataBase.inisoftkey = val;
  }

  static setSign() {
    String signContent =
        "${dataBase.businessid}${dataBase.encrypttypeid}${dataBase.platformusercode}${dataBase.goodscode}${dataBase.inisoftkey ?? ''}${dataBase.timestamp.toString()}${dataBase.data!.toString()}${crypt['slat']}${dataBase.platformtypeid}";
    dataBase.sign = EncryptUtils.ruikeySign(signContent);
  }

  static setData(Map<String, dynamic> val) async {
    int timestamp = DateTime.now().microsecondsSinceEpoch;

    dataBase.timestamp = timestamp;
    val['timestamp'] = timestamp;

    String? deviceId = await PlatformDeviceId.getDeviceId;
    val['maccode'] = deviceId;

    print(val);
    if (dataBase.encrypttypeid == 1) {
      dataBase.data = EncryptUtils.desEncrypt(jsonEncode(val), crypt['key']!);
    } else {
      dataBase.data = jsonEncode(val);
    }
  }

  static setBusinessid(int val) {
    dataBase.businessid = val;
  }

  // 初始化 鉴权接口
  static Future<RuikeyInitDataModel> initAppAuth() async {
    int timestamp = DateTime.now().microsecondsSinceEpoch;
    dataBase.timestamp = timestamp;

    setBusinessid(1);

    await setData({"requestflag": "防止破解数据", "versionname": "1.0"});

    setSign();

    Response response = await dio.post('http://api.ruikeyz.com/netver/webapi',
        data: jsonEncode(dataBase),
        options: Options(
          contentType: "application/json;charset=UTF-8",
          responseType: ResponseType.plain,
        ));

    Map<String, dynamic> result = json.decode(response.data.toString());

    RuikeyInitDataModel ruikeyInitDataModel = RuikeyInitDataModel.fromJson(
        json.decode(EncryptUtils.desDecrypt(result['data'], crypt['key']!)));
    dataBase.inisoftkey = ruikeyInitDataModel.inisoftkey;

    return ruikeyInitDataModel;
  }

  // 单码登录
  static Future<RuikeyReturnDataModel> loginAppAuth(String cardnum) async {
    int timestamp = DateTime.now().microsecondsSinceEpoch;
    dataBase.timestamp = timestamp;

    setBusinessid(4);

    await setData(
        {"requestflag": "防止破解数据", "versionname": "1.0", "cardnum": cardnum});

    setSign();

    Response response = await dio.post('http://api.ruikeyz.com/netver/webapi',
        data: jsonEncode(dataBase),
        options: Options(
          contentType: "application/json;charset=UTF-8",
          responseType: ResponseType.plain,
        ));

    RuikeyReturnDataModel result =
        ruikeyReturnDataModelFromJson(response.data.toString());

    return result;
  }

  // 退出登录
  static Future<RuikeyReturnDataModel> logoutAppAuth(
    String cardnum,
    String token,
  ) async {
    int timestamp = DateTime.now().microsecondsSinceEpoch;
    dataBase.timestamp = timestamp;

    setBusinessid(7);

    await setData({
      "requestflag": "防止破解数据",
      "versionname": "1.0",
      "token": token,
      "cardnumorusername": cardnum,
    });

    setSign();

    Response response = await dio.post('http://api.ruikeyz.com/netver/webapi',
        data: jsonEncode(dataBase),
        options: Options(
          contentType: "application/json;charset=UTF-8",
          responseType: ResponseType.plain,
        ));

    RuikeyReturnDataModel result =
        ruikeyReturnDataModelFromJson(response.data.toString());
    return result;
  }

  // 心跳检测
  static Future<RuikeyReturnDataModel> loopAppAuth(
    String cardnum,
    String token,
    String heartbeatkey,
  ) async {
    int timestamp = DateTime.now().microsecondsSinceEpoch;
    dataBase.timestamp = timestamp;

    setBusinessid(5);

    setData({
      "requestflag": "防止破解数据",
      "token": token,
      "cardnumorusername": cardnum,
      "heartBeatkey": heartbeatkey
    });

    setSign();

    Response response = await dio.post('http://api.ruikeyz.com/netver/webapi',
        data: jsonEncode(dataBase),
        options: Options(
          contentType: "application/json;charset=UTF-8",
          responseType: ResponseType.plain,
        ));

    RuikeyReturnDataModel result =
        ruikeyReturnDataModelFromJson(response.data.toString());

    print("result -- 没有 数据");
    print(result.toJson());
    return result;
  }
}
