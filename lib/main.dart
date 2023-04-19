import 'package:flutter/material.dart';

import 'screens/HomePage.dart';

//utils
import '../Utils/FileManager.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget{
  MyApp({Key? key}): super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>{

  @override
  void initState() {
    super.initState();
    FileManager.saveAppend("");
  }

  @override
  Widget build(BuildContext context) {

    Color coloreGenerale = Color.fromARGB(255, 0, 0, 0);
    ThemeData tema = ThemeData(scaffoldBackgroundColor: Color.fromARGB(255, 0, 0, 0), appBarTheme: AppBarTheme(color: Color.fromARGB(255, 0, 0, 0)));

    return MaterialApp(
      title: "BConnect",
      debugShowCheckedModeBanner: false,
      theme: tema,
      color: coloreGenerale,
      home: PrimaPagina(),
    );
  }

}





