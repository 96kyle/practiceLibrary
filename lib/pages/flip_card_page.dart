import 'package:carousel/widgets/bubble_widget.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';

class FlipCardPage extends StatefulWidget {
  const FlipCardPage({Key? key}) : super(key: key);

  @override
  State<FlipCardPage> createState() => _FlipCardPageState();
}

class _FlipCardPageState extends State<FlipCardPage> {
  final controller = FlipCardController();

  List<DateTime> abc = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            bubbleWidget(comment: '말풍선 테스트 입니다'),
            // SizedBox(height: 20),
            // FlipCard(
            //   controller: controller,
            //   direction: FlipDirection.HORIZONTAL,
            //   side: CardSide.FRONT,
            //   autoFlipDuration: Duration(milliseconds: 3000),
            //   speed: 1000,
            //   flipOnTouch: false,
            //   onFlip: () {},
            //   alignment: Alignment.bottomLeft,
            //   onFlipDone: (status) {
            //     print('앞면일 때 false 뒤면일 떄 true $status');
            //   },
            //   fill: Fill.fillFront,
            //   front: Container(
            //     padding: EdgeInsets.all(30),
            //     decoration: BoxDecoration(
            //       color: Colors.red,
            //       borderRadius: BorderRadius.all(Radius.circular(8.0)),
            //     ),
            //     child: Column(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: <Widget>[
            //         Text(
            //           'Front',
            //         ),
            //         Text(
            //           'Click here to flip back',
            //         ),
            //       ],
            //     ),
            //   ),
            //   back: Container(
            //     padding: EdgeInsets.all(30),
            //     decoration: BoxDecoration(
            //       color: Colors.blue,
            //       borderRadius: BorderRadius.all(Radius.circular(8.0)),
            //     ),
            //     child: Column(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: <Widget>[
            //         Text(
            //           'Back',
            //         ),
            //         Text(
            //           'Click here to flip front',
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            // SizedBox(
            //   height: 10,
            // ),
            // ElevatedButton(
            //   onPressed: controller.toggleCard,
            //   child: Text('카드 토글하기'),
            // ),
            // ElevatedButton(
            //   onPressed: controller.toggleCardWithoutAnimation,
            //   child: Text('카드 애니매이셥 없이 뒤집기'),
            // ),
            // ElevatedButton(
            //   onPressed: () => controller.skew(.4),
            //   child: Text('카드 기울이기'),
            // ),
            // ElevatedButton(
            //   onPressed: () => controller.hint(
            //     duration: Duration(milliseconds: 500),
            //     total: Duration(milliseconds: 500),
            //   ),
            //   child: Text('뒷면 잠깐 보여주기'),
            // ),
          ],
        ),
      ),
    );
  }
}
