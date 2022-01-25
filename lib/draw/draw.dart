import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class Draw extends StatefulWidget {
  const Draw({Key? key}) : super(key: key);

  @override
  _DrawState createState() => _DrawState();
}

class _DrawState extends State<Draw> {
  List<DrawingArea?> position = [];

  Color pickerColor = Colors.black;
  Color currentColor = Colors.black;

  double defaultWidth = 2;

  bool eraserMode = false;

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
        child: Icon(
          Icons.cancel,
          color: Colors.red,
          size: 60,
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            LayoutBuilder(builder: (context, constraint) {
              return Container(
                margin: EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 20,
                ),
                width: constraint.maxWidth,
                height: 500,
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
                            ..strokeWidth = defaultWidth));
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
                              ..strokeWidth = defaultWidth));
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
                      painter: MyCustomPainter(
                          position: position, color: pickerColor),
                    ),
                  ),
                ),
              );
            }),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 30,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(30),
                  )),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => Dialog(
                            child:
                                LayoutBuilder(builder: (context, constraint) {
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
                      },
                      child: Container(
                        child: Icon(
                          Icons.palette,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  RotationTransition(
                    turns: new AlwaysStoppedAnimation(315 / 360),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          currentColor = pickerColor;
                          pickerColor = Colors.white;
                          eraserMode = true;
                        });
                      },
                      child: Container(
                        width: 24,
                        height: 15,
                        decoration: BoxDecoration(
                          color: eraserMode ? Colors.blue : Colors.black,
                        ),
                        child: Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.fromLTRB(9, 0, 13, 0),
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          eraserMode = false;
                          pickerColor = currentColor;
                        });
                      },
                      child: Container(
                        child: Icon(
                          Icons.edit_sharp,
                          color: eraserMode ? Colors.black : Colors.blue,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Slider(
                      value: defaultWidth,
                      min: 0.0,
                      max: 20.0,
                      label: '${defaultWidth.round()}',
                      onChanged: (double newValue) {
                        setState(
                          () {
                            defaultWidth = newValue;
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              padding: EdgeInsets.symmetric(
                vertical: 5,
                horizontal: 20,
              ),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  )),
              child: TextButton(
                onPressed: () async {
                  saveImage();
                },
                child: Text('save'),
              ),
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

  Future<bool> saveImage() async {
    if (await Permission.storage.request().isGranted) {
      ui.Image image = await recorde;
      final ByteData? data =
          await image.toByteData(format: ui.ImageByteFormat.png);
      // Directory tempDir = await getApplicationDocumentsDirectory();
      // String tempPath = tempDir.path;
      // var filePath = tempPath + 'dpdl.png';
      // var filePath = '/storage/emulated/0/Download/tjfak.png';
      // var file = File(filePath);

      // print(filePath);

      final result = await ImageGallerySaver.saveImage(
          Uint8List.fromList(data!.buffer.asUint8List()),
          quality: 60,
          name: "${DateFormat('yyyyMMddhhmmss').format(DateTime.now())}");

      print(result);

      setState(() {
        position = [];
      });

      // file.writeAsBytesSync(data!.buffer.asInt8List());
      // file.writeAsStringSync("asdf");

      return true;
    } else {
      return false;
    }
  }
}

class MyCustomPainter extends CustomPainter {
  List<DrawingArea?> position;
  Color color;

  MyCustomPainter({
    required this.position,
    required this.color,
  });

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
