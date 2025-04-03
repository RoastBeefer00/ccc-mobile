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

    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(image: AssetImage('assets/images/ccc.png'), height: 150,),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "Our next meeting is...",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: ThemeColors.whitesOffWhite,
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            (nextEvent != null)
                ? EventCard(
                  name: nextEvent.name,
                  date: nextEvent.startDate,
                  location: nextEvent.location,
                )
                : CircularProgressIndicator(color: ThemeColors.whitesOffWhite),
            SizedBox(height: 20),
            Text(
              "Hope to see you there!",
                textAlign: TextAlign.center,
              style: TextStyle(
                color: ThemeColors.whitesOffWhite,
                fontSize: 30,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
