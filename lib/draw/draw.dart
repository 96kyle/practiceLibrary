import 'dart:io';
import 'dart:ui' as ui;
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:path_provider/path_provider.dart';

class Draw extends StatefulWidget {
  const Draw({Key? key}) : super(key: key);

  @override
  _DrawState createState() => _DrawState();
}

class _DrawState extends State<Draw> {
  List<DrawingArea?> position = [];

  Color pickerColor = Colors.black;

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
              height: 550,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: GestureDetector(
                onPanDown: (details) {
                  setState(() {
                    position.add(DrawingArea(
                        position: details.localPosition,
                        areaPaint: Paint()
                          ..strokeCap = StrokeCap.round
                          ..isAntiAlias = true
                          ..color = pickerColor
                          ..strokeWidth = 2.0));
                  });
                },
                onPanUpdate: (details) {
                  setState(() {
                    setState(() {
                      position.add(DrawingArea(
                          position: details.localPosition,
                          areaPaint: Paint()
                            ..strokeCap = StrokeCap.round
                            ..isAntiAlias = true
                            ..color = pickerColor
                            ..strokeWidth = 2.0));
                    });
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
                    painter:
                        MyCustomPainter(position: position, color: pickerColor),
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: () async {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => Dialog(
                    child: LayoutBuilder(builder: (context, constraint) {
                      return Container(
                        width: constraint.maxWidth,
                        height: constraint.maxHeight * 0.7,
                        margin: EdgeInsets.only(top: 30),
                        child: ColorPicker(
                          pickerColor: pickerColor,
                          onColorChanged: changeColor,
                        ),
                      );
                    }),
                  ),
                );
                print(pickerColor);
              },
              child: Text('색상선택'),
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

  void changeColor(Color color) {
    setState(() {
      pickerColor = color;
    });
  }

  Future<dynamic> get recorde {
    ui.PictureRecorder recorder = ui.PictureRecorder();
    Canvas canvas = Canvas(recorder);
    MyCustomPainter painter =
        MyCustomPainter(position: position, color: pickerColor);
    Size size = Size(400, 550);
    painter.paint(canvas, size);
    return recorder.endRecording().toImage(400, 550);
  }

  Future<File> saveImage() async {
    ui.Image image = await recorde;
    final ByteData? data =
        await image.toByteData(format: ui.ImageByteFormat.png);
    print(data!.buffer.asUint8List());
    Directory tempDir = await getApplicationDocumentsDirectory();
    String tempPath = tempDir.path;
    var filePath = tempPath + '/${DateTime.now().toString()}.png';

    File(filePath).writeAsBytesSync(data.buffer.asUint8List());

    return File(filePath);
  }
}

class MyCustomPainter extends CustomPainter {
  List<DrawingArea?> position;
  Color color;

  MyCustomPainter({required this.position, required this.color});

  @override
  void paint(Canvas canvas, Size size) async {
    Paint background = Paint()..color = Colors.white;
    Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.drawRect(rect, background);

    for (int i = 0; i < position.length - 1; i++) {
      if (position[i] != null && position[i + 1] != null) {
        Paint paint = position[i]!.areaPaint;
        canvas.drawLine(
            position[i]!.position, position[i + 1]!.position, paint);
      } else if (position[i] != null && position[i + 1] == null) {
        Paint paint = position[i]!.areaPaint;
        canvas.drawPoints(ui.PointMode.points, [position[i]!.position], paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class DrawingArea {
  Offset position;
  Paint areaPaint;

  DrawingArea({
    required this.position,
    required this.areaPaint,
  });
}
