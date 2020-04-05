import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// import 'dart:async';

class CalendarData with ChangeNotifier {
  String testing = "Data Provider works";
  List<Map> appointmentsList = [];

  List<Map<String, Object>> testArray = [
    {
      'DOW': 'Monday',
      'date': '03-09-2020',
      'appointments': [
        {'start': 2, 'color': 'purple', 'duration': 3, 'text': 'Place #1'},
        {'start': 8, 'color': 'yellow', 'duration': 5, 'text': 'Place #2'},
        {'start': 15, 'color': 'green', 'duration': 7, 'text': 'Place #3'},
      ]
    },
    {
      'DOW': 'Tuesday',
      'date': '03-10-2020',
      'appointments': [
        {'start': 2, 'color': 'purple', 'duration': 3, 'text': 'Place #4'},
        // {'start': 8, 'color': 'yellow', 'duration': 4, 'text': 'Place #5'},
        {'start': 15, 'color': 'green', 'duration': 3, 'text': 'Place #6'},
      ]
    },
    {
      'DOW': 'Thursday',
      'date': '03-12-2020',
      'appointments': [
        {'start': 2, 'color': 'purple', 'duration': 3, 'text': 'Place #10'},
        {'start': 8, 'color': 'yellow', 'duration': 4, 'text': 'Place #11'},
        // {'start': 15, 'color': 'green', 'duration': 3, 'text': 'Place #12'},
      ]
    },
    {
      'DOW': 'Friday',
      'date': '03-13-2020',
      'appointments': [
        // {'start': 2, 'color': 'purple', 'duration': 3, 'text': 'Place #13'},
        {'start': 8, 'color': 'yellow', 'duration': 4, 'text': 'Place #14'},
        {'start': 15, 'color': 'green', 'duration': 3, 'text': 'Place #15'},
      ]
    },
    {
      'DOW': 'Monday',
      'date': '03-16-2020',
      'appointments': [
        {'start': 2, 'color': 'purple', 'duration': 3, 'text': 'Place #1'},
        {'start': 8, 'color': 'yellow', 'duration': 5, 'text': 'Place #2'},
        {'start': 15, 'color': 'green', 'duration': 7, 'text': 'Place #3'},
      ]
    },
    {
      'DOW': 'Tuesday',
      'date': '03-17-2020',
      'appointments': [
        {'start': 2, 'color': 'purple', 'duration': 3, 'text': 'Place #4'},
        // {'start': 8, 'color': 'yellow', 'duration': 4, 'text': 'Place #5'},
        {'start': 15, 'color': 'green', 'duration': 3, 'text': 'Place #6'},
      ]
    },
    {
      'DOW': 'Thursday',
      'date': '03-19-2020',
      'appointments': [
        {'start': 2, 'color': 'purple', 'duration': 3, 'text': 'Place #10'},
        {'start': 8, 'color': 'yellow', 'duration': 4, 'text': 'Place #11'},
        // {'start': 15, 'color': 'green', 'duration': 3, 'text': 'Place #12'},
      ]
    },
    {
      'DOW': 'Friday',
      'date': '03-20-2020',
      'appointments': [
        // {'start': 2, 'color': 'purple', 'duration': 3, 'text': 'Place #13'},
        {'start': 8, 'color': 'yellow', 'duration': 4, 'text': 'Place #14'},
        {'start': 15, 'color': 'green', 'duration': 3, 'text': 'Place #15'},
      ]
    },
  ];

  CalendarData() {
    initializeApp();
  }

  void initializeApp() {
    print("initialized CalendarData Provider");
    testing = "";
    createCalendarFromAppointments();
    notifyListeners();
  }

  void setText(String text) {
    testing = text;
    notifyListeners();
  }

  // void makeAppointmentCheat(
  //     {String date, String time, String duration, String name, String color}) {
  //   print("day:$date, time:$time, duration:$duration");
  //   int index = getIndexFromDay(date);
  //   print(index);

  //   Object appt = testArray[index]['appointments'];
  //   int startTime = convertTime(time);
  //   print(startTime);
  //   print("duration: $duration");
  //   int durationStep = convertDuration(duration);
  //   print("durationStep: $durationStep");

  //   //appt.length - 1
  //   appt.insert(0, {
  //     'start': startTime,
  //     'color': color,
  //     'duration': durationStep,
  //     'text': name,
  //   });
  //   testArray[index]['appointments'] = appt;
  //   notifyListeners();
  // }

  int getIndexFromDay(String date) {
    int index =
        testArray.indexWhere((dateString) => dateString['date'] == date);
    return index;
  }

  int convertTime(String time) {
    List<String> splitTime = time.split(":");
    print("splitTime=$splitTime");
    int startStep = ((int.parse(splitTime[0]) - 6) * 2);
    print(startStep);
    return startStep;
  }

  int convertDuration(String duration) {
    return (double.parse(duration) * 2).round();
  }

  void createCalendarFromAppointments() {
    DateTime now = DateTime.now();
    DateTime start = now.add(Duration(days: -30));
    DateTime end = now.add(Duration(days: 31));
    Duration dayDifference = end.difference(start);

    List<DateTime> datetimes = List.generate(
        dayDifference.inDays, (index) => start.add(Duration(days: index)));
    datetimes.forEach((element) {
      String dayName = DateFormat('EEEEE').format(element);
      String date = DateFormat('MM-dd-yyyy').format(element);
      // https://pub.dev/documentation/intl/latest/intl/DateFormat-class.html

      Map<String, Object> dayObj = {
        'DOW': dayName,
        'date': date,
        'appointments': <Object>[]
      };
      appointmentsList.add(dayObj);
    });
    print(appointmentsList);

    testArray.forEach((element) {
      int index = appointmentsList
          .indexWhere((appointment) => appointment['date'] == element['date']);
      appointmentsList.removeAt(index);
      appointmentsList.insert(index, element);
    });
    print("------------------------");
    appointmentsList.forEach((element) {
      print(element['date']);
    });
  }
}
