import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:personal_calender/screens/home_screen.dart';

void main() {
  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //   statusBarColor: Colors.transparent,
  // ));
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        accentColor: Colors.deepOrange
      ),
      title: 'Personal Assistant',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: CalenderHome(),
    );
  }
}

