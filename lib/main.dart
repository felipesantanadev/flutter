import 'package:flutter/material.dart';
import './pages/random_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Startup name generator',
      theme: ThemeData(
        primaryColor: Colors.white
      ),
      home: RandomWords()
    );
  }
}