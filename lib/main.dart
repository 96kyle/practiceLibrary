import 'package:carousel/pages/carousel.dart';
import 'package:carousel/pages/loading.dart';
import 'package:carousel/pages/multipleItemDemo.dart';
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
      home: Loading(),
    );
  }
}
