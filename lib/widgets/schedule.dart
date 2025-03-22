import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io' show Platform;

class ClubEvent {
  final String name;
  final DateTime date;
  final String location;

  const ClubEvent({required this.name, required this.date, required this.location});

  ClubEvent.fromJson(Map<String, dynamic> json)
    : name = json['summary'] as String,
      date = DateTime.parse(json['start']['dateTime'] as String),
      // date = DateTime.parse("2025-03-03T10:00:00Z"),
      location = "TBD";
      // location = json['location'] as String;

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

Future<List<ClubEvent>> fetchSchedule() async {
  const androidApiKey = String.fromEnvironment('ANDROID_API_KEY', defaultValue: 'SOME_DEFAULT_VALUE');
  const iosApiKey = String.fromEnvironment('IOS_API_KEY', defaultValue: 'SOME_DEFAULT_VALUE');
  final apiKey = Platform.isAndroid ? androidApiKey : iosApiKey;
  final response = await http.get(Uri.parse("https://www.googleapis.com/calendar/v3/calendars/cruceschessclub@gmail.com/events?key=$apiKey&timeMin=2025-03-03T10:00:00Z&timeMax=2025-03-30T10:00:00Z"));
  var events = <ClubEvent>[];

  if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var json = jsonDecode(response.body) as Map<String, dynamic>;
      for (var item in json['items']) {
          events.add(ClubEvent.fromJson(item));
      }
      return events;
  } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load schedule');
  }
}


