import 'package:ccc_mobile/widgets/schedule.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/big_card.dart';
import '../widgets/schedule.dart';
import '../state.dart';

class HomePage extends StatelessWidget {
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
