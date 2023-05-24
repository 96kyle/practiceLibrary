import 'package:carousel/pages/datepicker/date_picker_page.dart';
import 'package:carousel/pages/flip_card_page.dart';
import 'package:carousel/pages/indicator_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Carousel',
      home: DatePickerPage(),
    );
  }
}
