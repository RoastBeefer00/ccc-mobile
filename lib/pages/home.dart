import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/event.dart';
import '../state.dart';
import '../widgets/schedule.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    // appState.updateSchedule();
    var events = appState.clubEvents;
    final nextEvent =  getNextEvent(events);

    final welcomeStyle = Theme.of(context).textTheme.headlineLarge!.copyWith(
        color: Theme.of(context).colorScheme.onPrimary,
    );

    return Center(
        child:  Column(
        mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text("Our next meeting will be at...", style: welcomeStyle),
            ),
            EventCard(name: nextEvent.name, date: nextEvent.date ,location: nextEvent.location),
            Text("We hope to see you there!", style: welcomeStyle),
          ],
        ),
    );
  }
}
