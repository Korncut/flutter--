import 'package:flutter/material.dart';
import 'package:week7_n/ui_profile.dart';
import 'package:week7_n/ui_productlist.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: PageProductlist());
  }
}