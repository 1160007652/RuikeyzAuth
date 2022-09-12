import 'package:flutter/material.dart';
import 'package:day/day.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ruikeyz_auth/model/ruikeyz_init.dart';
import 'package:ruikeyz_auth/services/auth.dart';
import 'input_auth.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});
  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isGoAction = false;
  final double version = 1.0;
  RuikeyInitDataModel? ruikeyInitData;

  @override
  void initState() {
    super.initState();
    AuthProvider.initAppAuth().then((RuikeyInitDataModel ruikeyInitDataModel) {
      setState(() {
        ruikeyInitData = ruikeyInitDataModel;
      });

      double originVersion = ruikeyInitDataModel.softinfo.newversionnum != ''
          ? double.parse(ruikeyInitDataModel.softinfo.newversionnum)
          : version;

      if (originVersion > version) {
        showDialog(
            context: context,
            barrierDismissible: ruikeyInitDataModel.softinfo.isforceupd == 1,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("更新"),
                content: Text(
                    "请更新最新的应用, 更新密码：${ruikeyInitDataModel.softinfo.diskpwd}"),
                actions: ruikeyInitDataModel.softinfo.isforceupd == 1
                    ? [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("取消"),
                        ),
                        TextButton(
                          onPressed: () {
                            launchUrl(Uri.parse(
                                ruikeyInitDataModel.softinfo.networkdiskurl));
                            Navigator.pop(context);
                          },
                          child: const Text("确定"),
                        )
                      ]
                    : [
                        TextButton(
                          onPressed: () {
                            launchUrl(Uri.parse(
                                ruikeyInitDataModel.softinfo.networkdiskurl));
                          },
                          child: const Text("确定"),
                        ),
                      ],
              );
            });
      }
    });

    initGotoActionPAge();
  }

  // 初始化数据，判断是否可以直接进入操作页面
  Future<void> initGotoActionPAge() async {
    final prefs = await SharedPreferences.getInstance();
    String? authcode = prefs.getString('authcode');

    if (authcode != null && authcode != '') {
      try {
        String apptime = "";
        //await EncryptUtils.aesDecrypt(authcode);

        final appNow = Day.fromString(apptime);
        if (appNow.diff(Day()) >= 0) {
          // ignore: use_build_context_synchronously
          Navigator.pushReplacementNamed(context, '/action');
        }
      } catch (_) {}
    }
    setState(() {
      isGoAction = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ruikeyInitData != null
          ? Container(
              color: const Color(0xFF252831),
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                opacity: isGoAction ? 1.0 : 0.0,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 85),
                      child: Center(
                        child: Text(
                          "${ruikeyInitData?.softinfo.softname} ${version.toString()}",
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 38,
                              letterSpacing: 12,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 520,
                            height: 300,
                            padding: const EdgeInsets.fromLTRB(32, 24, 32, 24),
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(25, 255, 255, 255),
                                borderRadius: BorderRadius.circular(10)),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("软件公告"),
                                  Text(ruikeyInitData!.softinfo.notice),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  const Text("最新消息"),
                                  Text(ruikeyInitData!.softinfo.basedata)
                                ],
                              ),
                            ), //systemGUID: systemGUID
                          ),
                          Container(
                            width: 520,
                            height: 300,
                            padding: const EdgeInsets.fromLTRB(32, 24, 32, 24),
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(25, 255, 255, 255),
                                borderRadius: BorderRadius.circular(10)),
                            child: const InputAuth(), //systemGUID: systemGUID
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          : const SizedBox.shrink(),
    );
  }
}
