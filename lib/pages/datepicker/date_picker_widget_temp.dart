import 'package:carousel/pages/datepicker/date_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DatePickerWidgetTemp extends StatefulWidget {
  const DatePickerWidgetTemp({
    this.returnDateType = ReturnDateType.each,
    this.initialDateList,
    this.initialDateRange,
    this.selectedColor = Colors.blue,
    this.rangeColor = Colors.grey,
    this.selectedFontColor,
    this.darkMode = false,
    Key? key,
  }) : super(key: key);

  final ReturnDateType returnDateType;
  final List<DateTime>? initialDateList;
  final DateTimeRange? initialDateRange;
  final Color selectedColor;
  final Color rangeColor;
  final Color? selectedFontColor;
  final bool darkMode;

  @override
  State<DatePickerWidgetTemp> createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidgetTemp> {
  late List<DateTime> _selectedDateList;

  List<DateTime> _calender = [];
  DateTime? _selectRangeStart;
  DateTime? _selectRangeEnd;
  late Color _selectedFontColor;

  late DateTime _viewMonth;

  @override
  void initState() {
    super.initState();

    _selectedDateList = widget.initialDateList ?? [];
    _selectRangeStart = widget.initialDateRange?.start ?? null;
    _selectRangeEnd = widget.initialDateRange?.end ?? null;
    _viewMonth = DateTime.now();
    _selectedFontColor = widget.darkMode ? Color(0xFF2C2C2C) : Colors.white;

    viewCalender();
    setState(() {});
  }

  List<String> weekNames = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];

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

  void selectDateRange(DateTime date) {
    if (_selectRangeStart != null && _selectRangeEnd != null) {
      _selectRangeStart = date;
      _selectRangeEnd = null;
      return;
    }

    if (_selectRangeStart == null) {
      _selectRangeStart = date;
      return;
    } else {
      if (_selectRangeStart == date) {
        _selectRangeStart = null;
        return;
      }

      if (date.isBefore(_selectRangeStart!)) {
        _selectRangeStart = date;
        return;
      }

      if (date.isAfter(_selectRangeStart!)) {
        _selectRangeEnd = date;
      }
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
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
          bottom: Radius.zero,
        ),
        color: widget.darkMode ? Color(0xFF2C2C2C) : Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    color: widget.darkMode ? Colors.white : Color(0xFF2C2C2C),
                  ),
                ),
              ),
              Text(
                _viewMonth.month < 10 ? '${_viewMonth.year}.0${_viewMonth.month}' : '${_viewMonth.year}.${_viewMonth.month}',
                style: GoogleFonts.prompt(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: widget.darkMode ? Colors.white : Color(0xFF2C2C2C),
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
                    color: widget.darkMode ? Colors.white : Color(0xFF2C2C2C),
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
                    style: GoogleFonts.prompt(
                      fontSize: 18,
                      color: index == 0
                          ? Colors.red
                          : index == 6
                              ? Colors.blue
                              : widget.darkMode
                                  ? Colors.white
                                  : Color(0xFF2C2C2C),
                    ),
                  ),
                ),
              ),
            ],
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
                    padding: EdgeInsets.only(bottom: 12),
                    child: Row(
                      children: [
                        ...List.generate(
                          7,
                          (index2) => Expanded(
                            child: GestureDetector(
                              onTap: _calender[index1 * 7 + index2].month != _viewMonth.month
                                  ? () {
                                      _viewMonth = DateTime(_calender[index1 * 7 + index2].year, _calender[index1 * 7 + index2].month);
                                      if (widget.returnDateType == ReturnDateType.each) {
                                        selectDate(_calender[index1 * 7 + index2]);
                                      } else {
                                        selectDateRange(_calender[index1 * 7 + index2]);
                                      }
                                      viewCalender();
                                      setState(() {});
                                    }
                                  : () {
                                      if (widget.returnDateType == ReturnDateType.each) {
                                        selectDate(_calender[index1 * 7 + index2]);
                                      } else {
                                        selectDateRange(_calender[index1 * 7 + index2]);
                                      }
                                      setState(() {});
                                    },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: widget.returnDateType == ReturnDateType.range &&
                                          _selectRangeStart != null &&
                                          _selectRangeEnd != null &&
                                          (_selectRangeStart!.isBefore(_calender[index1 * 7 + index2]) &&
                                              _selectRangeEnd!.isAfter(_calender[index1 * 7 + index2]))
                                      ? widget.rangeColor.withOpacity(.3)
                                      : null,
                                  gradient:
                                      _selectRangeStart != null && _selectRangeEnd != null && _selectRangeStart == _calender[index1 * 7 + index2]
                                          ? LinearGradient(
                                              tileMode: TileMode.clamp,
                                              colors: [
                                                Colors.transparent,
                                                widget.rangeColor.withOpacity(.3),
                                              ],
                                              stops: [.3, .5],
                                            )
                                          : _selectRangeStart != null && _selectRangeEnd != null && _selectRangeEnd == _calender[index1 * 7 + index2]
                                              ? LinearGradient(
                                                  tileMode: TileMode.clamp,
                                                  colors: [
                                                    widget.rangeColor.withOpacity(.3),
                                                    Colors.transparent,
                                                  ],
                                                  stops: [.3, .5],
                                                )
                                              : null,
                                ),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: dayBoxColor(_calender[index1 * 7 + index2]),
                                  ),
                                  child: Text(
                                    _calender[index1 * 7 + index2].day.toString(),
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.prompt(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      color: dayTextColor(_calender[index1 * 7 + index2]),
                                    ),
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
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(),
                  onPressed: () {},
                  child: Text('select'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Color dayBoxColor(DateTime date) {
    return widget.returnDateType == ReturnDateType.each
        ? _selectedDateList.indexOf(date) != -1
            ? widget.selectedColor
            : Colors.transparent
        : _selectRangeStart == date || _selectRangeEnd == date
            ? widget.selectedColor
            : Colors.transparent;
  }

  Color dayTextColor(DateTime date) {
    return widget.returnDateType == ReturnDateType.each
        ? _selectedDateList.indexOf(
                  date,
                ) !=
                -1
            ? _selectedFontColor
            : date.month != _viewMonth.month
                ? Colors.grey
                : date.weekday == 6
                    ? Colors.blue
                    : date.weekday == 7
                        ? Colors.red
                        : widget.darkMode
                            ? Colors.white
                            : Color(0xFF2C2C2C)
        : (_selectRangeStart == date || _selectRangeEnd == date)
            ? _selectedFontColor
            : date.month != _viewMonth.month
                ? Colors.grey
                : date.weekday == 6
                    ? Colors.blue
                    : date.weekday == 7
                        ? Colors.red
                        : widget.darkMode
                            ? Colors.white
                            : Color(0xFF2C2C2C);
  }
}
