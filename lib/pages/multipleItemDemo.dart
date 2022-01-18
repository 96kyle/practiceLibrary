// import 'package:carousel/model/imageModel.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';

// class MultipleItemDemo extends StatelessWidget {
//   final List<ImageModel> item = [
//     ImageModel(title: '애니', imageUrl: '1.jpg'),
//     ImageModel(title: '별 + 산', imageUrl: '2.jpg'),
//     ImageModel(title: '하늘', imageUrl: '3.png'),
//     ImageModel(title: '구름', imageUrl: '4.jpg'),
//     ImageModel(title: '캐릭터', imageUrl: '5.png'),
//     ImageModel(title: '캐릭터', imageUrl: '5.png'),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Multiple item in one slide demo')),
//       body: Container(
//           child: CarouselSlider.builder(
//         options: CarouselOptions(
//           aspectRatio: 2.0,
//           enlargeCenterPage: false,
//           viewportFraction: 1,
//         ),
//         itemCount: (item.length / 2).round(),
//         itemBuilder: (context, index, realIdx) {
//           final int first = index * 2;
//           final int second = first + 1;
//           return Row(
//             children: [first, second].map((idx) {
//               return Expanded(
//                 flex: 1,
//                 child: Container(
//                     margin: EdgeInsets.symmetric(horizontal: 10),
//                     child: Image.asset(
//                       'assets/${item[idx].imageUrl}',
//                       fit: BoxFit.fill,
//                     )),
//               );
//             }).toList(),
//           );
//         },
//       )),
//     );
//   }
// }
