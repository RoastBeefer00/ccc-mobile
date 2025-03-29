import 'package:ccc_mobile/state.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io' show Platform;

import 'package:provider/provider.dart';
import '../firebase_options.dart';

var androidApiKey = DefaultFirebaseOptions.android.apiKey;
var iosApiKey = DefaultFirebaseOptions.ios.apiKey;
final apiKey = Platform.isAndroid ? androidApiKey : iosApiKey;

class ClubEvent {
  final String name;
  final DateTime date;
  final String? location;

  const ClubEvent({required this.name, required this.date, this.location});

  factory ClubEvent.fromJson(Map<String, dynamic> json) {
    if (json['location'] == null) {
      return ClubEvent(
        name: json['summary'] as String,
        date: DateTime.parse(json['start']['dateTime'] as String).toLocal(),
        location: null,
      );
    } else {
      return ClubEvent(
        name: json['summary'] as String,
        date: DateTime.parse(json['start']['dateTime'] as String).toLocal(),
        location: json['location'] as String,
      );
    }
  }
}

Future<List<ClubEvent>> fetchSchedule(DateTime start, DateTime end) async {
  final startDate = start.toIso8601String();
  final endDate = end.toIso8601String();
  final response = await http.get(
    Uri.parse(
      "https://www.googleapis.com/calendar/v3/calendars/cruceschessclub@gmail.com/events?key=$apiKey&timeMin=${startDate}Z&timeMax=${endDate}Z",
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
      if (item['recurrence'] != null) {
        var recurringEvents = await getRecurringEvents(start, end, item['id']);
        events.addAll(recurringEvents);
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

Future<List<ClubEvent>> getRecurringEvents(
  DateTime start,
  DateTime end,
  String eventId,
) async {
  final startDate = start.toIso8601String();
  final endDate = end.toIso8601String();
  final response = await http.get(
    Uri.parse(
      "https://www.googleapis.com/calendar/v3/calendars/cruceschessclub@gmail.com/events/$eventId/instances?key=$apiKey&timeMin=${startDate}Z&timeMax=${endDate}Z",
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

Future<void> updateState(BuildContext context) async {
  final appState = context.read()<MyAppState>();
  var date = DateTime.now();
  var start = getFirstDayOfTheMonth(date);
  var end = getLastDayOfTheMonth(DateTime(date.year, date.month + 2, 1));
  final schedule = await fetchSchedule(start, end);
  appState.clubEvents = schedule;
  print("updated state");
}

DateTime getFirstDayOfTheMonth(DateTime date) {
  return DateTime(date.year, date.month, 1);
}

DateTime getLastDayOfTheMonth(DateTime date) {
  return DateTime(date.year, date.month + 1, 0);
}

ClubEvent? getNextEvent(List<ClubEvent> events) {
  var now = DateTime.now();
  for (var event in events) {
    if (event.date.isAfter(now)) {
      return event;
    }
  }
  return null;
}
