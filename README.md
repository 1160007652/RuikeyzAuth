# RuikeyzAuth Flutter Desktop 授权DEMO 


> 配置路径

``` dart
lib/services/auth.dart

static Map<String, String> crypt = {"slat": "xxxxx", "key": "xxxxxx"};

在这里配置加密的参数，slat、key
```


``` dart
lib/main.dart


RuikeyReqBaseModel ruikeyReqBaseModel = RuikeyReqBaseModel(
  encrypttypeid: 1,
  platformusercode: "xxxxxx",
  goodscode: "xxxxxx",
);


在这里配置 encrypttypeid、platformusercode、goodscode 参数
```



> 打包 MacOS 应用

flutter build macos
appdmg macos/assets/appdmg.json RuikeyzAuth.dmg

> 打包 Windows 应用

flutter build windows
