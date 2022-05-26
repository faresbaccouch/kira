// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:kira/view/home_page.dart';
import 'package:provider/provider.dart';

import 'controller/game_controller.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => GameController(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    Provider.of<GameController>(context, listen: false).getplayerFromPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        brightness: Brightness.light,
        textTheme: TextTheme(
          headline1: TextStyle(
              fontSize: 25.0,
              fontFamily: "kira",
              fontWeight: FontWeight.bold,
              color: Colors.white),
          headline3: TextStyle(
              fontSize: 18.0,
              fontFamily: "kira",
              fontWeight: FontWeight.bold,
              color: Colors.white),
          headline2: TextStyle(
              fontSize: 25.0,
              fontFamily: "kira",
              fontWeight: FontWeight.bold,
              color: Colors.red),
          headline4: TextStyle(
              fontSize: 18,
              fontFamily: "popins",
              fontWeight: FontWeight.bold,
              color: Colors.black),
          headline5: TextStyle(
              fontSize: 18.0,
              fontFamily: "popins",
              fontWeight: FontWeight.bold,
              color: Colors.white),
        ),
      ),
      home: HomePage(),
    );
  }
}
