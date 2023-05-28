import 'package:flutter/material.dart';

class DatePickerWidgetTemp extends StatefulWidget {
  const DatePickerWidgetTemp({
    Key? key,
    required this.selectedList,
    required this.selectDate,
  }) : super(key: key);

  final List<DateTime> selectedList;
  final void Function(DateTime)? selectDate;

  @override
  State<DatePickerWidgetTemp> createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidgetTemp> {
  List<DateTime> _selectedDateList = [];

  List<DateTime> _calender = [];

  late DateTime _viewMonth;

  @override
  void initState() {
    super.initState();

    _viewMonth = DateTime.now();

    viewCalender();
    setState(() {});
  }

  List<String> weekNames = ['Sun', 'Mon', 'Tue', 'Wed', 'Tue', 'Fri', 'Sat'];

  void viewCalender() {
    _calender.clear();

    int startWeekDay = DateTime(_viewMonth.year, _viewMonth.month, 1).weekday == 7 ? 0 : DateTime(_viewMonth.year, _viewMonth.month, 1).weekday;

    print(startWeekDay);

    for (int i = 1; i <= 42; i++) {
      _calender.add(DateTime(_viewMonth.year, _viewMonth.month, i - startWeekDay));
    }
  }

  void goBackMonth() {
    _viewMonth = DateTime(_viewMonth.year, _viewMonth.month - 1, 1);

    viewCalender();
  }

  void goFrontMonth() {
    _viewMonth = DateTime(_viewMonth.year, _viewMonth.month + 1, 1);

    viewCalender();
  }

  void selectDate(DateTime date) {
    if (_selectedDateList.indexOf(date) == -1) {
      _selectedDateList.add(date);
    } else {
      _selectedDateList.remove(date);
    }
  }

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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  goBackMonth();
                  setState(() {});
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Icon(
                    Icons.arrow_back_ios,
                  ),
                ),
              ),
              Text(
                _viewMonth.month < 10 ? '${_viewMonth.year}.0${_viewMonth.month}' : '${_viewMonth.year}.${_viewMonth.month}',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
              GestureDetector(
                onTap: () {
                  goFrontMonth();
                  setState(() {});
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Icon(
                    Icons.arrow_forward_ios,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              ...List.generate(
                7,
                (index) => Expanded(
                  child: Text(
                    weekNames[index],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      color: index == 0
                          ? Colors.red
                          : index == 6
                              ? Colors.blue
                              : Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 12,
          ),
          Divider(
            height: 0,
            thickness: 1,
            color: Colors.black12,
          ),
          SizedBox(
            height: 12,
          ),
          GestureDetector(
            onHorizontalDragStart: (details) {
              goFrontMonth();
              setState(() {});
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ...List.generate(
                  6,
                  (index1) => Padding(
                    padding: EdgeInsets.only(bottom: 4),
                    child: Row(
                      children: [
                        ...List.generate(
                          7,
                          (index2) => Expanded(
                            child: GestureDetector(
                              onTap: _calender[index1 * 7 + index2].month != _viewMonth.month
                                  ? () {}
                                  : () {
                                      widget.selectDate!(_calender[index1 * 7 + index2]);
                                      selectDate(_calender[index1 * 7 + index2]);
                                      setState(() {});
                                    },
                              child: Container(
                                padding: EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: _selectedDateList.indexOf(_calender[index1 * 7 + index2]) != -1 ? Colors.greenAccent : Colors.transparent,
                                ),
                                child: Text(
                                  _calender[index1 * 7 + index2].day.toString(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: _selectedDateList.indexOf(_calender[index1 * 7 + index2]) != -1 ? FontWeight.bold : FontWeight.w500,
                                    fontSize: 16,
                                    fontStyle: FontStyle.italic,
                                    color: _calender[index1 * 7 + index2].month != _viewMonth.month
                                        ? Colors.grey
                                        : _selectedDateList.indexOf(
                                                  _calender[index1 * 7 + index2],
                                                ) !=
                                                -1
                                            ? Colors.white
                                            : _calender[index1 * 7 + index2].weekday == 6
                                                ? Colors.blue
                                                : _calender[index1 * 7 + index2].weekday == 7
                                                    ? Colors.red
                                                    : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
