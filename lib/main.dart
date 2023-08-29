import 'package:carousel/pages/drag_and_drop_page.dart';
import 'package:carousel/pages/flip_card_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DragAndDropPage(),
    );
  }
}
