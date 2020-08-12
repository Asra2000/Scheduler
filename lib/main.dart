import 'package:flutter/material.dart';
import 'screens/notes_screen.dart';
import 'screens/schedule_screen.dart';
import 'services/constants.dart';
import 'screens/home_screen.dart';
import 'screens/input_screen.dart';
import 'screens/alarm_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        accentColor: lightPinkColor,
        primaryColor: lightBlueColor,
        focusColor: lightBlackColor,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/note': (context) => InputScreen(),
        '/alarm': (context) => AlarmScreen(),
        '/schedule':(context) => Scheduler(),
        '/notes': (context) => NotesScreen(),
      },
    );
  }
}
