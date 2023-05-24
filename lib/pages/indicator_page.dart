import 'dart:async';

import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IndicatorPage extends StatefulWidget {
  const IndicatorPage({Key? key}) : super(key: key);

  @override
  State<IndicatorPage> createState() => _IndicatorPageState();
}

class _IndicatorPageState extends State<IndicatorPage> {
  final controller = PageController(
    viewportFraction: 0.8,
    keepPage: false,
    initialPage: 0,
  );
  final pages = List.generate(
      6,
      (index) => Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.grey.shade300,
            ),
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            child: Container(
              height: 280,
              child: Center(
                  child: Text(
                "Page $index",
                style: TextStyle(color: Colors.indigo),
              )),
            ),
          ));

  void autoPagination() async {
    await Timer.periodic(Duration(seconds: 3), (timer) {
      controller.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void initState() {
    autoPagination();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Smooth Page Indicator',
        ),
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 240,
            child: PageView.builder(
              controller: controller,
              // itemCount: pages.length,
              itemBuilder: (_, index) {
                return pages[index % pages.length];
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: SmoothPageIndicator(
              controller: controller,
              count: pages.length,
              effect: const WormEffect(
                dotHeight: 16,
                dotWidth: 16,
                type: WormType.thinUnderground,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: SmoothPageIndicator(
              controller: controller,
              count: pages.length,
              effect: JumpingDotEffect(
                dotHeight: 16,
                dotWidth: 16,
                jumpScale: .7,
                verticalOffset: 15,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: SmoothPageIndicator(
              controller: controller,
              count: pages.length,
              effect: ScrollingDotsEffect(
                activeStrokeWidth: 2.6,
                activeDotScale: 1.3,
                maxVisibleDots: 5,
                radius: 8,
                spacing: 10,
                dotHeight: 16,
                dotWidth: 16,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: SmoothPageIndicator(
              controller: controller,
              count: pages.length,
              effect: SwapEffect(
                radius: 8,
                spacing: 10,
                dotHeight: 16,
                dotWidth: 16,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: Container(
              child: SmoothPageIndicator(
                controller: controller,
                count: pages.length,
                effect: CustomizableEffect(
                  activeDotDecoration: DotDecoration(
                    width: 20,
                    height: 12,
                    rotationAngle: 180,
                    verticalOffset: -10,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  dotDecoration: DotDecoration(
                    width: 12,
                    height: 12,
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(16),
                    verticalOffset: 0,
                  ),
                  spacing: 12.0,
                  activeColorOverride: (i) => colors[i],
                  inActiveColorOverride: (i) => colors[i],
                ),
              ),
            ),
          ),
          SizedBox()
        ],
      ),
    );
  }
}

final colors = const [
  Colors.red,
  Colors.green,
  Colors.greenAccent,
  Colors.amberAccent,
  Colors.blue,
  Colors.amber,
];
