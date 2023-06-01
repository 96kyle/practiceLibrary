import 'package:carousel/pages/datepicker/date_picker.dart';
import 'package:carousel/pages/datepicker/date_picker_widget_temp.dart';
import 'package:flutter/material.dart';

class DatePickerPage extends StatefulWidget {
  const DatePickerPage({Key? key}) : super(key: key);

  @override
  State<DatePickerPage> createState() => _DatePickerPageState();
}

class _DatePickerPageState extends State<DatePickerPage> {
  List<DateTime> test1 = [];
  DateTimeRange? test2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ASDASD',
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ...List.generate(
              test1.length,
              (index) => Text(
                test1[index].toString().substring(0, 10),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                var result = await showDialog(
                  context: context,
                  builder: (context) => Dialog(
                    insetPadding: EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                        bottom: Radius.circular(20),
                      ),
                    ),
                    child: DatePickerWidgetTemp(
                      returnDateType: ReturnDateType.each,
                      initialDateList: [
                        DateTime.now(),
                      ],
                      contrastMode: ContrastMode.white,
                      rangeColor: Colors.grey.withOpacity(.3),
                    ),
                  ),
                );
                if (result != null) {
                  test1.addAll(result);
                }
                setState(() {});
              },
              child: Text('Dialog Example'),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
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
                    returnDateType: ReturnDateType.range,
                    initialDateRange: DateTimeRange(start: DateTime(2023, 06, 12), end: DateTime.now().add(Duration(days: 18))),
                    contrastMode: ContrastMode.dark,
                    rangeColor: Colors.grey.withOpacity(.3),
                  ),
                );
                if (result != null) {
                  test2 = result;
                }
                setState(() {});
              },
              child: Text('Bottom Sheet Example'),
            ),
            Text(test2 == null ? '' : '${test2!.start.toString().substring(0, 10)} ~ ${test2!.end.toString().substring(0, 10)}')
          ],
        ),
      ),
    );
  }
}
