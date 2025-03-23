import 'package:flutter/material.dart';
import './widgets/schedule.dart';

class MyAppState extends ChangeNotifier {
  var clubEvents = <ClubEvent>[];
  // late Future<ClubEvent> schedule;
  //
  Future<void> updateSchedule() async {
    var date = DateTime.now();
    var start = getFirstDayOfTheMonth(date);
    var end = getLastDayOfTheMonth(DateTime(date.year, date.month + 2, 1));
    print('start: $start, end: $end');
    clubEvents = await fetchSchedule(start, end);
    notifyListeners();
  }
}
