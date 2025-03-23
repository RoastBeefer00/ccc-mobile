import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io' show Platform;

class ClubEvent {
  final String name;
  final DateTime date;
  final String? location;

  const ClubEvent({required this.name, required this.date, this.location});

  factory ClubEvent.fromJson(Map<String, dynamic> json) {
    if (json['location'] == null) {
      return ClubEvent(name: json['summary'] as String, date: DateTime.parse(json['start']['dateTime'] as String), location: null);
    } else {
      return ClubEvent(name: json['summary'] as String, date: DateTime.parse(json['start']['dateTime'] as String), location: json['location'] as String);
    }
  }
    // : name = json['summary'] as String,
    //   date = DateTime.parse(json['start']['dateTime'] as String),
    //   // date = DateTime.parse("2025-03-03T10:00:00Z"),
    //   // location = "TBD";
    // if (json['location'] != null)
    //   location = json['location'] as String;

  // return switch (json) {
  //   {'summary': String bar, 'start.dateTime': DateTime date, 'location': String location} => ClubEvent(
  //     name: bar,
  //     date: date,
  //     location: location,
  //   ),
  //   _ => throw const FormatException('Failed to load schedule.'),
  // };
  // }
}

Future<List<ClubEvent>> fetchSchedule(DateTime start, DateTime end) async {
  const androidApiKey = String.fromEnvironment(
    'ANDROID_API_KEY',
    defaultValue: 'SOME_DEFAULT_VALUE',
  );
  const iosApiKey = String.fromEnvironment(
    'IOS_API_KEY',
    defaultValue: 'SOME_DEFAULT_VALUE',
  );
  final apiKey = Platform.isAndroid ? androidApiKey : iosApiKey;
  final startDate = start.toIso8601String();
  final endDate = end.toIso8601String();
  final response = await http.get(
    Uri.parse(
      // "https://www.googleapis.com/calendar/v3/calendars/cruceschessclub@gmail.com/events?key=$apiKey&timeMin=${startDate}Z&timeMax=${endDate}Z",
      "https://www.googleapis.com/calendar/v3/calendars/cruceschessclub@gmail.com/events?key=$apiKey",
    ),
  );
  var events = <ClubEvent>[];

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    var json = jsonDecode(response.body) as Map<String, dynamic>;
    for (var item in json['items']) {
        if (item['start']['dateTime'] == null) {
            continue;
        }
      var event = ClubEvent.fromJson(item);
      if (event.date.isAfter(start) && event.date.isBefore(end)) {
        events.add(event);
      }
    }
    events.sort((a, b) => a.date.compareTo(b.date));
    return events;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception(
      'Error: ${response.statusCode}.  Please check your internet connection.',
    );
  }
}

DateTime getFirstDayOfTheMonth(DateTime date) {
  return DateTime(date.year, date.month, 1);
}

DateTime getLastDayOfTheMonth(DateTime date) {
  return DateTime(date.year, date.month + 1, 0);
}

ClubEvent getNextEvent(List<ClubEvent> events) {
  var now = DateTime.now();
  for (var event in events) {
    if (event.date.isAfter(now)) {
      return event;
    }
  }
  return events.last;
}
