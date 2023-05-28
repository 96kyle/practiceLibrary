import 'package:carousel/pages/datepicker/date_picker_widget_temp.dart';
import 'package:flutter/material.dart';

class DatePickerPage extends StatefulWidget {
  const DatePickerPage({Key? key}) : super(key: key);

  @override
  State<DatePickerPage> createState() => _DatePickerPageState();
}

class _DatePickerPageState extends State<DatePickerPage> {
  List<DateTime> selectedList = [];
  void Function(DateTime value)? selectDate(value) {
    if (selectedList.indexOf(value) == -1) {
      selectedList.add(value);
    } else {
      selectedList.remove(value);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DatePickerWidgetTemp(
              selectDate: (DateTime value) => selectDate(value),
              selectedList: [],
            ),
            ...List.generate(
              selectedList.length,
              (index) => Text(
                selectedList[index].toString(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
