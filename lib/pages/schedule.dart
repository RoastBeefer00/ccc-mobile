import 'package:ccc_mobile/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/event.dart';
import '../widgets/month.dart';
import '../state.dart';

class SchedulePage extends StatefulWidget {
  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var events = appState.clubEvents;
    var months = getMonths(events);
    var month = months[selectedIndex];
    for (var event in month.events) {
      print("${event.name} => ${event.startDate} - ${event.endDate}");
    }

    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: ThemeColors.chessBlackBackground,
          appBar: TabBar(
            dividerColor: ThemeColors.whitesOffWhite,
            indicatorColor: ThemeColors.chessGreenLight,
            indicatorWeight: 4,
            indicatorSize: TabBarIndicatorSize.tab,
            unselectedLabelColor: ThemeColors.whitesOffWhite,
            labelColor: ThemeColors.chessGreenLight,
            labelStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            tabs: [
              for (var i = 0; i < months.length; i++) Tab(text: months[i].name),
            ],
          ),
          body: TabBarView(
            children: [
              for (var i = 0; i < months.length; i++)
                ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    for (var event in months[i].events)
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: EventCard(
                          name: event.name,
                          date: event.startDate,
                          location: event.location,
                        ),
                      ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
