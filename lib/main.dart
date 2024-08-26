import 'package:flutter/material.dart';
import 'package:flutter_node_store67/themes/styles.dart';
import 'package:flutter_node_store67/utils/app_router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      initialRoute: AppRouter.welcome,
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
