import 'package:carousel/pages/datepicker/date_picker_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DatePickerPage(),
      theme: ThemeData(fontFamily: 'Prompt'),
    );
  }
}
