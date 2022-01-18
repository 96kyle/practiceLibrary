import 'package:carousel/store/imageStore.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class Carousel extends StatefulWidget {
  const Carousel({Key? key}) : super(key: key);

  @override
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  final item = ImageStore.instance.imageList;

  final CarouselController controller = CarouselController();

  int dotIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('캐러셀'),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 10),
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: CarouselSlider(
                  options: CarouselOptions(
                    aspectRatio: 1,
                    viewportFraction: 0.8,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    // autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    onPageChanged:
                        (index, CarouselPageChangedReason changeReason) {
                      setState(() {
                        print(controller);
                        dotIndex = index;
                      });
                    }, //저 reason이 뭐지
                  ),
                  carouselController: controller,
                  items: item.map((i) {
                    return Builder(builder: (BuildContext context) {
                      return Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        child: Container(
                          color: Colors.blue,
                          child: Image.asset(
                            'assets/${i.imageUrl}',
                            fit: BoxFit.fill,
                          ),
                        ),
                      );
                    });
                  }).toList()),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...List.generate(item.length, (index) {
                  return Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 5,
                      vertical: 5,
                    ),
                    child: dotIndex == index
                        ? Icon(Icons.circle)
                        : Icon(Icons.circle_outlined),
                  );
                })
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () => controller.previousPage(),
                  child: Text('이전페이지'),
                ),
                TextButton(
                  onPressed: () => controller.nextPage(),
                  child: Text('다음페이지'),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...List.generate(
                  item.length,
                  (index) {
                    return InkWell(
                      onTap: () {
                        controller.animateToPage(index);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        // alignment: Alignment.center,
                        child: Text(
                          '${index + 1}',
                          style: TextStyle(
                            fontSize: 25,
                          ),
                        ),
                      ),
                    );
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
