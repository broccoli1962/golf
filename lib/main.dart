import 'package:flutter/material.dart';
import 'package:golf/playpage.dart';
import 'package:golf/registerpage.dart';

void main() => runApp(const myApp());

class myApp extends StatelessWidget {
  const myApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Golf',
      home: register(),
    );
  }
}
