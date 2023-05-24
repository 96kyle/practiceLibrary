import 'package:carousel/pages/datepicker/date_formatter.dart';
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
  late List<DateTime> _selectedDateList;
  late DateTime? _selectDateRangeStart;
  late DateTime? _selectDateRangeEnd;
  late DateTime _firstDate;
  late DateTime _lastDate;
  late DateTime _viewMonth;

  List<DateTime> _dateWeek = [];

  late int _firstWeekEmpty;
  late int _lastWeekEmpty;

  @override
  void initState() {
    super.initState();
    _selectedDateList = widget.selectDateList ?? [];
    _selectDateRangeStart = widget.selectDateRange?.start ?? null;
    _selectDateRangeEnd = widget.selectDateRange?.end ?? null;
    _firstDate = widget.firstDate ?? DateTime(2000);
    _lastDate = widget.lastDate ?? DateTime(2030);

    if (widget.datePickerType == ReturnDateType.each) {
      _viewMonth = _selectedDateList.isEmpty ? DateTime.now().add(Duration(days: 60)) : _selectedDateList[0];
    } else {
      _viewMonth = _selectDateRangeStart ?? DateTime.now();
    }

    viewCalender();
  }

  List<String> weekNames = ['Sun', 'Mon', 'Tue', 'Wed', 'Tue', 'Fri', 'Sat'];

  void viewCalender() {
    _dateWeek.clear();
    for (int i = 0; i < DateFormatter.thisMonthLastDay(_viewMonth).day; i++) {
      _dateWeek.add(DateTime(_viewMonth.year, _viewMonth.month, i + 1));
    }

    _firstWeekEmpty = _dateWeek[0].weekday == 7 ? 0 : _dateWeek[0].weekday;
    _lastWeekEmpty = 6 - (_dateWeek.last.weekday == 7 ? 0 : _dateWeek.last.weekday);
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ...List.generate(
                ((_dateWeek.last.day + _firstWeekEmpty + _lastWeekEmpty) / 7).floor(),
                (index1) => Padding(
                  padding: EdgeInsets.only(bottom: 4),
                  child: Row(
                    children: [
                      ...List.generate(
                        7,
                        (index2) => Expanded(
                          child: index1 * 7 + index2 < _firstWeekEmpty
                              ? Container(
                                  padding: EdgeInsets.all(
                                    14,
                                  ),
                                  child: Text(
                                    DateTime(_viewMonth.year, _viewMonth.month, index2 + 1 - _firstWeekEmpty).day.toString(),
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontStyle: FontStyle.italic,
                                      color: Colors.grey[300],
                                    ),
                                  ),
                                )
                              : index1 * 7 + index2 >= _dateWeek.length + _firstWeekEmpty
                                  ? Container(
                                      padding: EdgeInsets.all(
                                        14,
                                      ),
                                      child: Text(
                                        DateTime(
                                          _viewMonth.year,
                                          _viewMonth.month,
                                        ).day.toString(),
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontStyle: FontStyle.italic,
                                        ),
                                      ),
                                    )
                                  : GestureDetector(
                                      onTap: () {
                                        selectDate(_dateWeek[index1 * 7 + index2 - _firstWeekEmpty]);
                                        setState(() {});
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(14),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: _selectedDateList.indexOf(_dateWeek[index1 * 7 + index2 - _firstWeekEmpty]) != -1
                                              ? Colors.pinkAccent
                                              : Colors.transparent,
                                        ),
                                        child: Text(
                                          _dateWeek[index1 * 7 + index2 - _firstWeekEmpty].day.toString(),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontWeight: _selectedDateList.indexOf(_dateWeek[index1 * 7 + index2 - _firstWeekEmpty]) != -1
                                                ? FontWeight.bold
                                                : FontWeight.w500,
                                            fontSize: 16,
                                            fontStyle: FontStyle.italic,
                                            color: _selectedDateList.indexOf(
                                                      _dateWeek[index1 * 7 + index2 - _firstWeekEmpty],
                                                    ) !=
                                                    -1
                                                ? Colors.white
                                                : _dateWeek[index1 * 7 + index2 - _firstWeekEmpty].weekday == 6
                                                    ? Colors.blue
                                                    : _dateWeek[index1 * 7 + index2 - _firstWeekEmpty].weekday == 7
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
          )
        ],
      ),
    );
  }
}

enum ReturnDateType { each, range }
