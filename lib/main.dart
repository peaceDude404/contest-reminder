import 'package:flutter/material.dart';
import 'home_screen.dart';

void main() {
  runApp(Contest());
}

class Contest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: home_screen(),
    );
  }
}
