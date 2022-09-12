import 'package:flutter/material.dart';
import 'package:ruikeyz_auth/model/ruikeyz_req.dart';
import 'package:ruikeyz_auth/services/auth.dart';
import 'package:window_manager/window_manager.dart';
import 'package:provider/provider.dart';
import 'package:ruikeyz_auth/screens/action/action_page.dart';
import 'package:ruikeyz_auth/screens/auth/auth_page.dart';
import 'package:ruikeyz_auth/stores/user.dart';

RuikeyReqBaseModel ruikeyReqBaseModel = RuikeyReqBaseModel(
  encrypttypeid: 1,
  platformusercode: "xxxxxx",
  goodscode: "xxxxxx",
);

void main() async {
  AuthProvider.setDataBase(ruikeyReqBaseModel);

  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
    size: Size(1200, 700),
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    // titleBarStyle: TitleBarStyle.hidden,
    maximumSize: Size(1200, 700),
    minimumSize: Size(1200, 700),
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  runApp(const MyApp());
}

// width：700 ，height: 500

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserStore()),
      ],
      child: MaterialApp(
        title: 'Ruikeyz Auth',
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.dark,
        theme: ThemeData(colorScheme: const ColorScheme.light()),
        routes: {
          '/': (BuildContext context) => const AuthPage(),
          '/action': (BuildContext context) => const ActionPage(),
          // '/ruler': (BuildContext context) => const RulerPage(),
        },
        darkTheme: ThemeData(
          colorScheme: const ColorScheme.dark(),
          primarySwatch: Colors.yellow,
        ),
      ),
    );
  }
}
