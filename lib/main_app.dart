import 'package:flutter/material.dart';

class MainApp extends StatelessWidget {
  final String flavor;
  const MainApp({
    Key? key,
    required this.flavor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Flavors Example',
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(title: Text(flavor)),
        ));
  }
}
