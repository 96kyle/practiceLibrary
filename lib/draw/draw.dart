import 'dart:io';
import 'dart:ui' as ui;
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class Draw extends StatefulWidget {
  const Draw({Key? key}) : super(key: key);

  @override
  _DrawState createState() => _DrawState();
}

class _DrawState extends State<Draw> {
  List<Offset?> position = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        title: Text('그림판'),
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          setState(() {
            position = [];
          });
        },
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          child: Icon(
            Icons.remove,
            color: Colors.red,
            size: 40,
          ),
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(
                vertical: 20,
              ),
              width: 400,
              height: 600,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: GestureDetector(
                onPanDown: (details) {
                  setState(() {
                    position.add(details.localPosition);
                  });
                },
                onPanUpdate: (details) {
                  setState(() {
                    position.add(details.localPosition);
                  });
                },
                onPanEnd: (details) {
                  setState(() {
                    position.add(null);
                  });
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  child: CustomPaint(
                    painter: MyCustomPainter(position: position),
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: () async {
                saveImage();
              },
              child: Text('save'),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> get recorde {
    ui.PictureRecorder recorder = ui.PictureRecorder();
    Canvas canvas = Canvas(recorder);
    MyCustomPainter painter = MyCustomPainter(position: position);
    Size size = Size(400, 600);
    painter.paint(canvas, size);
    return recorder.endRecording().toImage(400, 600);
  }

  Future<File> saveImage() async {
    print(await recorde);
    ui.Image image = await recorde;
    final ByteData? data =
        await image.toByteData(format: ui.ImageByteFormat.png);
    print(data!.buffer.asUint8List());
    Directory tempDir = await getApplicationDocumentsDirectory();
    String tempPath = tempDir.path;
    var filePath = tempPath + '/${DateTime.now().toString()}.png';
    File(filePath).writeAsBytesSync(data.buffer.asUint8List());

    print(filePath);

    return File(filePath);
  }
}

class MyCustomPainter extends CustomPainter {
  List<Offset?> position;

  MyCustomPainter({required this.position});

  @override
  void paint(Canvas canvas, Size size) async {
    Paint background = Paint()..color = Colors.white;
    Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.drawRect(rect, background);

    Paint paint = Paint();
    paint.color = Colors.red;
    paint.style = PaintingStyle.fill;
    paint.strokeWidth = 2.0;
    paint.isAntiAlias = true;
    paint.strokeCap = StrokeCap.round;

    for (int i = 0; i < position.length - 1; i++) {
      if (position[i] != null && position[i + 1] != null) {
        canvas.drawLine(position[i]!, position[i + 1]!, paint);
      } else if (position[i] != null && position[i + 1] == null) {
        canvas.drawPoints(ui.PointMode.points, [position[i]!], paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
