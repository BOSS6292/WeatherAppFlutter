import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/pages/home_page.dart';
import 'package:weather_app/provider/data_provider.dart';
import 'package:weather_app/theme/app_theme.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (BuildContext context) => DataProvider(),
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: darkTheme,
      home: const HomePage(),
    );
  }
}
