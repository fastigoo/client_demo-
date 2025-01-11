import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:async';

dynamic getResponseData(Response response) {
  return response.data is String ? jsonDecode(response.data) : response.data;
}

bool checkValidStateCode(Response response) {
  return response.statusCode! >= 200 || response.statusCode! < 300;
}

String trimDateToString(DateTime date) {
  return date.toString().split(' ')[0];
}

FutureOr<TimeOfDay?> getTimeOfDayFunction({required context, required initTime}) async {
  return await showTimePicker(
    context: context,
    initialTime: initTime,
  );
}

bool compareTimeOfDays(TimeOfDay start, TimeOfDay end) {
  return start.hour < end.hour || (start.hour == end.hour && start.minute < end.minute);
}

TimeOfDay restToMidnight(TimeOfDay start, TimeOfDay end) {
  return TimeOfDay(hour: (start.hour - end.hour), minute: (start.minute - end.minute));
}

TimeOfDay parseTimeOfDayFromString(String d) {
  return TimeOfDay(hour: int.parse(d.split(':')[0]), minute: int.parse(d.split(':')[1]));
}
