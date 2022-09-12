import 'package:flutter/material.dart';
import 'package:clipboard/clipboard.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ruikeyz_auth/model/ruikeyz_login.dart';
import 'package:ruikeyz_auth/model/ruikeyz_return.dart';
import 'package:ruikeyz_auth/services/auth.dart';
import 'package:ruikeyz_auth/stores/user.dart';
import 'package:ruikeyz_auth/utils/djs_enable.dart';
import 'package:ruikeyz_auth/utils/encrypt_utils.dart';
import 'package:window_manager/window_manager.dart';

class InputAuth extends StatefulWidget {
  const InputAuth({super.key});

  @override
  State<InputAuth> createState() => _InputAuthState();
}

class _InputAuthState extends State<InputAuth> {
  AuthProvider authProvider = AuthProvider();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController authCodeController = TextEditingController();
  String authCode = "";
  bool isCopy = false;
  String msg = '';

  // 验证授权码是否可以使用
  String? handleValidatorAuthCode(String? value) {
    if (value == null || value.isEmpty) {
      return '请输入正确的激活码';
    }

    return null;
  }

  //  提交表单
  void handleOnClickSubmit() async {
    final userStore = Provider.of<UserStore>(context, listen: false);
    final prefs = await SharedPreferences.getInstance();
    var form = formKey.currentState;
    if (form!.validate()) {
      try {
        form.save();
        String? authToken = prefs.getString('authToken');
        if (authToken != null) {
          await AuthProvider.logoutAppAuth(authCode, authToken);
        }

        RuikeyReturnDataModel loginReturnData =
            await AuthProvider.loginAppAuth(authCode);

        if (loginReturnData.code == 0) {
          RuikeyLoginDataModel loginData = ruikeyLoginDataModelFromJson(
              EncryptUtils.desDecrypt(
                  loginReturnData.data, AuthProvider.crypt['key']!));

          userStore.setRuikeyLoginData(loginData);
          userStore.setLoopHeartbeatkey(loginData.heartbeatkey);

          AuthProvider.loopAppAuth(
              authCode, loginData.token, loginData.heartbeatkey);

          String enableUseTime = djsEnable(
              loginData.endtime.toString(), loginData.servertimestamp);

          windowManager.setTitle("软件可用时长，还剩 $enableUseTime");

          await prefs.setString('authcode', authCode);
          await prefs.setString('authToken', loginData.token);

          // ignore: use_build_context_synchronously
          Navigator.pushReplacementNamed(context, '/action');
        } else {
          setState(() {
            msg = loginReturnData.msg;
          });
          windowManager.setTitle("ruikeyz_auth");
        }
      } catch (_) {
        return;
      }
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const Text(
                "联系商家：",
                style: TextStyle(fontSize: 14),
              ),
              const Expanded(
                child: Text(
                  "xxxxxxx@qq.com",
                  style: TextStyle(fontSize: 14, color: Colors.yellow),
                ),
              ),
              TextButton(
                onPressed: (() {
                  FlutterClipboard.copy("xxxxxxx@qq.com").then((value) {
                    setState(() {
                      isCopy = !isCopy;
                    });
                  });
                }),
                child: const Text("复制联系地址"),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 30),
            child: Row(
              children: [
                const Expanded(
                  child: Text(
                    "请复制 「 机器码」 向作者购买激活码 ",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Text(
                  isCopy ? '已复制' : '',
                  style: const TextStyle(fontSize: 16, color: Colors.orange),
                ),
              ],
            ),
          ),
          TextFormField(
            autofocus: true,
            obscureText: true,
            keyboardType: TextInputType.text,
            controller: authCodeController,
            decoration: const InputDecoration(
              hintText: '请输入授权码',
            ),
            onSaved: (value) {
              authCode = value!;
            },
            validator: handleValidatorAuthCode,
          ),
          Container(
            height: 46,
            margin: const EdgeInsets.only(top: 20),
            child: ElevatedButton(
              onPressed: handleOnClickSubmit,
              child: const Text(
                '激活',
              ),
            ),
          ),
          const SizedBox(height: 8),
          Center(
              child: Text(
            msg,
            style: const TextStyle(color: Colors.red),
          )),
        ],
      ),
    );
  }
}
