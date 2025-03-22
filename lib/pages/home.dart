import 'package:ccc_mobile/widgets/schedule.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/big_card.dart';
import '../widgets/schedule.dart';
import '../state.dart';

class GeneratorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // var appState = context.watch<MyAppState>();
    var schedule = fetchSchedule();

    // IconData icon;
    // if (appState.favorites.contains(pair)) {
    //   icon = Icons.favorite;
    // } else {
    //   icon = Icons.favorite_border;
    // }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
FutureBuilder<List<ClubEvent>>(
  future: schedule,
  builder: (context, snapshot) {
    if (snapshot.hasData) {
      return ListView(
        children: [
        for (var event in snapshot.data!) ListTile(title: BigCard(name: event.name, date: event.date)),
        ],
      );
    } else if (snapshot.hasError) {
      return Text('${snapshot.error}');
    }

    // By default, show a loading spinner.
    return const CircularProgressIndicator();
  },
)
        ],
      ),
    );
  }
}
