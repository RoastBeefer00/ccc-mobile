import 'package:ccc_mobile/widgets/schedule.dart';
import 'package:ccc_mobile/widgets/event.dart';

class Month {
  final String name;
  final List<ClubEvent> events;

  const Month({required this.name, required this.events});

  void addEvent(ClubEvent event) {
    events.add(event);
  }
}

// Take a list of events and return a list of Month objects
List<Month> getMonths(List<ClubEvent> events) {
  var months = <Month>[];
  var monthNums = getMonthNums(events);
  for (var num in monthNums) {
    var month = Month(name: monthAsString(num), events: []);
    for (var event in events) {
      if (event.startDate.month == num) {
        month.addEvent(event);
      }
    }
    months.add(month);
  }
  return months;
}

// Go through list of events and return a list of unique month numbers
// i.e. events from January, February, and March would return [1, 2, 3]
List<int> getMonthNums(List<ClubEvent> events) {
  var months = <int>[];
  for (var event in events) {
    if (!months.contains(event.startDate.month)) {
      months.add(event.startDate.month);
    }
  }
  return months;
}
