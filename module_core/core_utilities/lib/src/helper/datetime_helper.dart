import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class DateTimeHelper {
  static int getCurrentMonth() {
    var now = new DateTime.now();
    var formatter = new DateFormat('MM');
    String formattedDate = formatter.format(now);
    return int.parse(formattedDate);
  }

  static int getCurrentYear() {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy');
    String formattedDate = formatter.format(now);
    return int.parse(formattedDate);
  }

  static String parseMonth(String _date) {
    if (_date.isEmpty) {
      return "";
    } else {
      String fullDateTimeFormat = "MMMM";
      String originDateTimeFormat = "MM";
      String result = new DateFormat(fullDateTimeFormat).format(DateTime.parse(
          DateFormat(originDateTimeFormat).parse(_date).toString()));
      return result;
    }
  }

  static String parseNormalDate(String _date) {
    initializeDateFormatting('en_EN', null);
    if (_date.isEmpty) {
      return "";
    } else {
      String fullDateTimeFormat = "EEEE, dd MMMM yyyy";
      String originDateTimeFormat = "dd-MM-yyyyy";
      String result = new DateFormat(fullDateTimeFormat, "en_EN").format(
          DateTime.parse(
              DateFormat(originDateTimeFormat).parse(_date).toString()));
      return result;
    }
  }

  static String parseReverseDate(String _date) {
    initializeDateFormatting('en_EN', null);
    if (_date.isEmpty) {
      return "";
    } else {
      String fullDateTimeFormat = "EEEE, dd MMMM yyyy";
      String originDateTimeFormat = "yyyy-MM-dd";
      String result = new DateFormat(fullDateTimeFormat, "en_EN").format(
          DateTime.parse(
              DateFormat(originDateTimeFormat).parse(_date).toString()));
      return result;
    }
  }

  static DateTime parseHour(String _date) {
    initializeDateFormatting('en_EN', null);
    if (_date.isEmpty) {
      return DateTime.now();
    } else {
      String originDateTimeFormat = "HH:mm aa";
      DateTime date = DateTime.parse(
          DateFormat(originDateTimeFormat).parse(_date).toString());
      return date;
    }
  }

  static String fullDateTimeHoursFormat(String _dateTime) {
    if (_dateTime.isEmpty) {
      return "";
    } else {
      String fullDateTimeFormat = "EEEE, dd MMM yyyy, hh:mm";
      String result =
          new DateFormat(fullDateTimeFormat).format(DateTime.parse(_dateTime));
      return result;
    }
  }

  static String dateTimeHoursFormat(String _dateTime) {
    if (_dateTime.isEmpty) {
      return "";
    } else {
      String fullDateTimeFormat = "dd MMM yyyy, hh:mm";
      String result =
          new DateFormat(fullDateTimeFormat).format(DateTime.parse(_dateTime));
      return result;
    }
  }

  static String fullDateTimeFormat(String _dateTime) {
    initializeDateFormatting('en_EN', null);
    if (_dateTime.isEmpty) {
      return "";
    } else {
      String fullDateTimeFormat = "EEEE, dd MMMM yyyy";
      String result = new DateFormat(fullDateTimeFormat, "en_EN")
          .format(DateTime.parse(_dateTime));
      return result;
    }
  }

  static String fullDateFormat(String _dateTime) {
    initializeDateFormatting('en_EN', null);
    if (_dateTime.isEmpty) {
      return "";
    } else {
      String fullDateTimeFormat = "dd/MM/yyyy";
      String result = new DateFormat(fullDateTimeFormat, "en_EN")
          .format(DateTime.parse(_dateTime));
      return result;
    }
  }

  static String dayMonthFormat(String _dateTime) {
    if (_dateTime.isEmpty) {
      return "";
    } else {
      String fullDateTimeFormat = "EEEE, dd MMM";
      String result =
          new DateFormat(fullDateTimeFormat).format(DateTime.parse(_dateTime));
      return result;
    }
  }
}
