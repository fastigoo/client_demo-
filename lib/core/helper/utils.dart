import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:nb_utils/nb_utils.dart';

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


void showToast({
  String message = '',
  ToastGravity gravity = ToastGravity.BOTTOM,
  Toast length = Toast.LENGTH_SHORT,
}) {
  toast(
    message,
    gravity: gravity,
    length: length,
  );
}

String getNormalizedDistance(double distance) {
  if (distance < 1000) {
    return '${distance.toStringAsFixed(0)} m';
  } else {
    return '${(distance / 1000).toStringAsFixed(2)} km';
  }
}

String getNormalizedTime(double time) {
  if (time < 60) {
    return '${time.toStringAsFixed(0)} sec';
  } else if (time < 3600) {
    return '${(time / 60).toStringAsFixed(0)} min';
  } else {
    return '${(time / 3600).toStringAsFixed(2)} hr';
  }
}

Color getStatusColor(String status) {
  switch (status) {
    case 'Pending':
      return Colors.orange;
    case 'Confirmed':
      return Colors.green;
    case 'Delivered':
      return Colors.red;
    case 'OnDelivery':
      return Colors.blue;
    default:
      return Colors.black;
  }
}
