import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/event.dart';
import '../state.dart';

class SchedulePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    // appState.updateSchedule();
    var events = appState.clubEvents;
    print("events: $events");
    // var date = DateTime.now();
    // var start = getFirstDayOfTheMonth(date);
    // var end = getLastDayOfTheMonth(date);
    // var schedule = fetchSchedule(start, end);

    // IconData icon;
    // if (appState.favorites.contains(pair)) {
    //   icon = Icons.favorite;
    // } else {
    //   icon = Icons.favorite_border;
    // }

    return Center(
        child: ListView(
            children: [
            for (var event in events)
            ListTile(
                title: EventCard(name: event.name, date: event.date ,location: event.location),
                ),
            ],
        )
    );
  }
}

