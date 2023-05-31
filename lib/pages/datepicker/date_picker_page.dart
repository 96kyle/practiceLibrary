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
            Builder(builder: (ctx) {
              return ElevatedButton(
                onPressed: () async {
                  var result = await showModalBottomSheet(
                    isScrollControlled: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                        bottom: Radius.zero,
                      ),
                    ),
                    context: context,
                    builder: (context) => DatePickerWidgetTemp(
                      returnDateType: ReturnDateType.each,
                      initialDateList: [DateTime.now()],
                      darkMode: false,
                      rangeColor: Colors.grey,
                    ),
                  );
                },
                child: Text('click me'),
              );
            }),
          ],
        ),
      ),
    );
  }
}
