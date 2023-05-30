import 'package:carousel/pages/datepicker/date_formatter.dart';
import 'package:carousel/pages/datepicker/date_picker.dart';
import 'package:flutter/material.dart';

class DatePickerWidget extends StatefulWidget {
  const DatePickerWidget({
    Key? key,
    this.selectDateList,
    this.selectDateRange,
    this.firstDate,
    this.lastDate,
    this.datePickerType = ReturnDateType.each,
  }) : super(key: key);

  final List<DateTime>? selectDateList;
  final DateTimeRange? selectDateRange;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final ReturnDateType datePickerType;

  @override
  State<DatePickerWidget> createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  @override
  void initState() {
    super.initState();
  }

  int zz = 1;

  List<String> weekNames = ['Sun', 'Mon', 'Tue'];

  final controller = PageController(initialPage: 1);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 30,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 200,
            child: PageView.builder(
              onPageChanged: (value) => {
                if (1 < value)
                  {
                    weekNames.add('zzzz'),
                    weekNames.removeAt(0),
                    print(weekNames),
                    controller.jumpToPage(1),
                    setState(() {}),
                  },
                if (1 > value)
                  {
                    weekNames.insert(0, 'gkgkgk'),
                    weekNames.removeLast(),
                    print(weekNames),
                    controller.jumpToPage(1),
                    setState(() {}),
                  }
              },
              itemCount: 3,
              controller: controller,
              itemBuilder: (context, index) => Text(
                weekNames[index],
              ),
            ),
          )
        ],
      ),
    );
  }
}
