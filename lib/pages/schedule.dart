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
      print(event.name);
    }
    // var theme = Theme.of(context);
    //
    // void onItemTapped(int index) {
    //   setState(() {
    //     selectedIndex = index;
    //   });
    // }

    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: ThemeColors.graysBackground,
          appBar: TabBar(
              dividerColor: ThemeColors.greensPrimary,
              indicatorColor: ThemeColors.greensDarkest,
              indicatorWeight: 4,
              indicatorSize: TabBarIndicatorSize.tab,
              unselectedLabelColor: ThemeColors.graysText,
              labelColor: ThemeColors.greensDarkest,
              labelStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              tabs: [
            for (var i = 0; i < months.length; i++)
              Tab(
                text: months[i].name,
              ),
              ],
            ),
          body: TabBarView(
            children: [
            for (var i = 0; i < months.length; i++)
              ListView(
            children: [
              for (var event in months[i].events)
                ListTile(
                  title: EventCard(
                    name: event.name,
                    date: event.date,
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
    // return Center(
    // return DefaultTabController(length: 3, child: Column(
    //   children: [
    //     TabBar(
    //       tabs: [
    //         for (var i = 0; i < months.length; i++)
    //           Tab(
    //             text: months[i].name,
    //           ),
    //       ],
    //     ),
    //     TabBarView(
    //       children: [
    //         for (var i = 0; i < months.length; i++)
    //           ListView(
    //         children: [
    //           for (var event in months[i].events)
    //             ListTile(
    //               title: EventCard(
    //                 name: event.name,
    //                 date: event.date,
    //                 location: event.location,
    //               ),
    //             ),
    //         ],
    //           ),
    //       ],
    //     ),
    //   ],
    //   )
    // );
    // return Center(
    //   child: Column(
    //     children: [
    //       SizedBox(height: 20),
    //       Row(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         spacing: 20,
    //         children: [
    //           for (var i = 0; i < months.length; i++)
    //             ElevatedButton(
    //               onPressed: () {
    //                 onItemTapped(i);
    //               },
    //               style: ElevatedButton.styleFrom(
    //                 foregroundColor:
    //                     i == selectedIndex
    //                         ? theme.colorScheme.onPrimaryContainer
    //                         : theme.colorScheme.onSecondary,
    //                 backgroundColor:
    //                     i == selectedIndex
    //                         ? theme.colorScheme.primaryContainer
    //                         : theme.colorScheme.secondary,
    //               ),
    //               child: Text(months[i].name),
    //             ),
    //         ],
    //       ),
    //       Expanded(
    //         child: ListView(
    //           children: [
    //             for (var event in month.events)
    //               ListTile(
    //                 title: EventCard(
    //                   name: event.name,
    //                   date: event.date,
    //                   location: event.location,
    //                 ),
    //               ),
    //           ],
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}
