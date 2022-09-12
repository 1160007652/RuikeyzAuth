import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ruikeyz_auth/model/ruikeyz_loop.dart';
import 'package:ruikeyz_auth/model/ruikeyz_return.dart';

import 'package:ruikeyz_auth/services/auth.dart';
import 'package:ruikeyz_auth/stores/user.dart';
import 'package:ruikeyz_auth/utils/djs_enable.dart';
import 'package:ruikeyz_auth/utils/encrypt_utils.dart';
import 'package:window_manager/window_manager.dart';

class ActionPage extends StatefulWidget {
  const ActionPage({super.key});

  @override
  State<ActionPage> createState() => _ActionPageState();
}

class _ActionPageState extends State<ActionPage> {
  Timer? timer;

  @override
  void initState() {
    super.initState();

    initLoopAuth();
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }

  Future<void> initLoopAuth() async {
    final userStore = Provider.of<UserStore>(context, listen: false);

    final prefs = await SharedPreferences.getInstance();
    String? authcode = prefs.getString('authcode');

    if (authcode != null) {
      timer = Timer.periodic(
        const Duration(minutes: 5), // minutes
        (inTimer) async {
          if (userStore.ruikeyLoginData!.heartbeatkey == '') {
            return;
          }
          RuikeyReturnDataModel ruikeyReturnData =
              await AuthProvider.loopAppAuth(authcode,
                  userStore.ruikeyLoginData!.token, userStore.loopHeartbeatkey);

          if (ruikeyReturnData.code != 0) {
            if (ruikeyReturnData.code == 4003) {
              Timer(const Duration(minutes: 3), () {
                windowManager.close();
              });
              showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("提示"),
                      content: const Text("账号到期，还剩3分钟结束使用"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("确定"),
                        ),
                      ],
                    );
                  });

              inTimer.cancel();
            }
          } else {
            RuikeyLoopDataModel ruikeyLoopDataModel =
                ruikeyLoopDataModelFromJson(EncryptUtils.desDecrypt(
                    ruikeyReturnData.data.toString(),
                    AuthProvider.crypt['key']!));
            userStore.setLoopHeartbeatkey(ruikeyLoopDataModel.heartbeatkey);
            String enableUseTime = djsEnable(
                ruikeyLoopDataModel.endtime.toString(),
                ruikeyLoopDataModel.servertimestamp);

            windowManager.setTitle("软件可用时长，还剩 $enableUseTime");
          }
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Text("软件已经激活，可以开始使用应用了"),
    ));
  }
}
