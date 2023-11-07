import 'package:flutter/material.dart';

Future<TimeOfDay?> timePicker(context, TimeOfDay time) {
  return showTimePicker(
    context: context,
    initialTime: time,
    initialEntryMode: TimePickerEntryMode.input,
    builder: (context, child) {
      return MediaQuery(
        data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
        child: child!,
      );
    },
  );
}

Future<DateTime?> datePicker(context, DateTime init) {
  return showDatePicker(
    context: context,
    initialDate: init,
    firstDate: DateTime(2015),
    lastDate: DateTime(2100),
  );
}
