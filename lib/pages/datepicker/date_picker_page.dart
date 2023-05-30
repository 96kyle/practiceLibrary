import 'package:carousel/pages/datepicker/date_picker.dart';
import 'package:carousel/pages/datepicker/date_picker_widget.dart';
import 'package:carousel/pages/datepicker/date_picker_widget_temp.dart';
import 'package:flutter/material.dart';

class DatePickerPage extends StatefulWidget {
  const DatePickerPage({Key? key}) : super(key: key);

  @override
  State<DatePickerPage> createState() => _DatePickerPageState();
}

class _DatePickerPageState extends State<DatePickerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ASDASD',
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => Dialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      child: DatePickerWidgetTemp(
                        returnDateType: ReturnDateType.range,
                        darkMode: true,
                      ),
                    ),
                  );
                },
                child: Text('click me')),
          ],
        ),
      ),
    );
  }
}
