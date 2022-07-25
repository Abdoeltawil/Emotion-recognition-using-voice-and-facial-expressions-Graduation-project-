import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import "Home.dart";
import 'loginWidget.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,

      home: loginWidget(),

    );
  }
}
