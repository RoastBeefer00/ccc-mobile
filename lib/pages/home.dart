import 'package:ccc_mobile/colors.dart';
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
    final nextEvent = getNextEvent(events);
    var theme = Theme.of(context);

    final welcomeStyle = Theme.of(context).textTheme.headlineLarge!.copyWith(
      color: Theme.of(context).colorScheme.onPrimary,
    );

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text("Our next meeting is...", style: TextStyle(color: ThemeColors.blacksText, fontSize: 30, fontWeight: FontWeight.w500)),
          ),
          (nextEvent != null)
              ? EventCard(
                name: nextEvent.name,
                date: nextEvent.date,
                location: nextEvent.location,
              )
              : CircularProgressIndicator(color: theme.colorScheme.onPrimary),
          SizedBox(height: 20),
          Text("Hope to see you there!", style: TextStyle(color: ThemeColors.blacksText, fontSize: 30, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}

