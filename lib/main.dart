import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:sia_app/core/service_locator.dart';
import 'package:sia_app/theme.dart';
import 'package:sia_app/ui/pages/login.dart';

void main() async {

  await Hive.initFlutter();

  initialize(); // getit

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.lightTheme,
      themeMode: ThemeMode.light,
      home: const LoginPage(),
    );
  }
}
