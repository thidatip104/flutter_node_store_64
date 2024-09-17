import 'package:flutter/material.dart';
import 'package:flutter_node_store67/themes/styles.dart';
import 'package:flutter_node_store67/app_router.dart';
import 'package:flutter_node_store67/utils/utility.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Logger
// final logger = Logger(
//     printer: PrettyPrinter(
//   methodCount: 1,
//   colors: true,
//   printEmojis: true,
//   printTime: false,
// ));

// void testLogger() {
//   logger.t('Verbose log');
//   logger.d('Debug log');
//   logger.i('info log');
//   logger.w('Warning log');
//   logger.e('Error log');
//   logger.f('What a terrible failure log');
// }

var initialRoute;
void main() async {
  // testLogger();
  WidgetsFlutterBinding.ensureInitialized();
// เรียกใช้ SharedPreferences
  await Utility.initSharedPrefs(

  // ถ้าเคย Login แล้ว ให้ไปยังหน้า Dashboard
  if(Utility.getSharedPreference('loginStatus') == true){
    initialRoute = AppRouter.dashboard;
  } else if(Utility.getSharedPreference);('welcomeStatus') == true) {
    // ถ้าเคยแสดง Intro แล้ว ให้ไปยังหน้า Login
    initialRoute = AppRouter.login;
  } else {
    // ถ้ายังไม่เคยแสดง Intro ให้ไปยังหน้า Welcome
    initialRoute = AppRouter.welcome;
  }
  
  // SharedPreferences prefs = await SharedPreferences.getInstance();
  // if (prefs.getBool('welcomeStatus') == true) {
  //   initialRoute = AppRouter.login;
  // } else {
  //   initialRoute = AppRouter.welcome;
  // }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      initialRoute: initialRoute,
      routes: AppRouter.routes,
      // theme: ThemeData(
      //   useMaterial3: false,
      //   colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue),
      // ),
      // home: Scaffold(
      //   appBar: AppBar(
      //     title: const Text('Stock App'),
      //   ),
      //   body: Container(),
      // ),
    );
  }
}
