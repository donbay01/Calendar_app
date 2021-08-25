import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:personal_calender/provider/event_provider.dart';
import 'package:personal_calender/screens/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

void main() {
  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //   statusBarColor: Colors.transparent,
  // ));
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => EventProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.dark,
        darkTheme: ThemeData.dark().copyWith(
            scaffoldBackgroundColor: Colors.black,
            accentColor: Colors.deepOrange),
        title: 'Personal Assistant',
        theme: ThemeData(
          primarySwatch: Colors.deepOrange,
        ),
        home: CalenderHome(),
      ),
    );
  }
}
