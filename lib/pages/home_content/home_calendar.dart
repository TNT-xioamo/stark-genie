import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';

final today = DateUtils.dateOnly(DateTime.now());

class StarkCalendar extends StatefulWidget {
  const StarkCalendar({Key? key}) : super(key: key);
  @override
  _userPageContent createState() => _userPageContent();
}

class _userPageContent extends State<StarkCalendar> {
  final config = CalendarDatePicker2Config(
    calendarType: CalendarDatePicker2Type.multi,
    selectedDayHighlightColor: Colors.teal[800],
    weekdayLabelTextStyle: const TextStyle(
      color: Colors.black87,
      fontWeight: FontWeight.bold,
    ),
    controlsTextStyle: const TextStyle(
      color: Colors.black,
      fontSize: 12,
      fontWeight: FontWeight.bold,
    ),
  );
  final List<DateTime?> _rangeDatePickerValueWithDefaultValue = [today];
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      height: 240,
      decoration: new BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
          borderRadius: new BorderRadius.all(
            const Radius.circular(11.0),
          ),
          boxShadow: []),
      child: CalendarDatePicker2(
        config: config,
        value: _rangeDatePickerValueWithDefaultValue,
      ),
    );
  }
}
