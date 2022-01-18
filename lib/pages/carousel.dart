import 'package:carousel/model/imageModel.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class Carousel extends StatefulWidget {
  const Carousel({Key? key}) : super(key: key);

  @override
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  final List<ImageModel> item = [
    ImageModel(title: '애니', imageUrl: '1.jpg'),
    ImageModel(title: '별 + 산', imageUrl: '2.jpg'),
    ImageModel(title: '하늘', imageUrl: '3.png'),
    ImageModel(title: '구름', imageUrl: '4.jpg'),
    ImageModel(title: '캐릭터', imageUrl: '5.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('캐러셀'),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 10),
        child: CarouselSlider(
            options: CarouselOptions(
              aspectRatio: 16 / 9,
              viewportFraction: 0.8,
              initialPage: 0,
              enableInfiniteScroll: true,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayCurve: Curves.fastOutSlowIn,
              // enlargeCenterPage: true,
              onPageChanged: (index, reason) {
                setState(() {
                  print('인덱스 : ${index}');
                  print('타이틀 : ${item[index].title}');
                });
              }, //저 reason이 뭐지
            ),
            items: item.map((i) {
              return Builder(builder: (BuildContext context) {
                return Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: Container(
                    child: Image.asset(
                      'assets/${i.imageUrl}',
                      fit: BoxFit.fill,
                    ),
                  ),
                );
              });
            }).toList()),
      ),
    );
  }
}
