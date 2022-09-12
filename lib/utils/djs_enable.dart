import 'package:day/day.dart';

String djsEnable(String endtime, int servertimestamp) {
  int dayTime = Day.fromString(endtime).diff(
      Day.fromDateTime(DateTime.fromMillisecondsSinceEpoch(servertimestamp)),
      'd');

  Day? hourTimeServerTime =
      Day.fromDateTime(DateTime.fromMillisecondsSinceEpoch(servertimestamp))
          .add(dayTime, 'd');

  int hourTime =
      Day.fromString(endtime.toString()).diff(hourTimeServerTime!, 'h');

  Day? minuteTimeServerTime = hourTimeServerTime.add(hourTime, 'h');

  int minuteTime =
      Day.fromString(endtime.toString()).diff(minuteTimeServerTime!, 'minute');

  String result = "";

  if (dayTime > 0) {
    result = "${dayTime.toString()}天";
  }
  if (hourTime > 0) {
    result += "${hourTime.toString()}时";
  }
  if (minuteTime > 0) {
    result += "${minuteTime.toString()}分";
  }

  return result;
}
