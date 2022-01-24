import 'package:flutter/material.dart';

class Test2 extends StatefulWidget {
  final int count;
  const Test2({Key? key, required this.count}) : super(key: key);

  @override
  _Test2State createState() => _Test2State();
}

class _Test2State extends State<Test2> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          itemCount: widget.count,
          itemBuilder: (BuildContext context, int index) {
            return Text('${index}');
          }),
    );
  }
}
