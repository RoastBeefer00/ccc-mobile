import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state.dart';

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final headerStyle = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );
    final listStyle = theme.textTheme.displaySmall!.copyWith(
      color: theme.colorScheme.onPrimary,
    );
    var appState = context.watch<MyAppState>();
    // if (appState.favorites.isEmpty) {
    //   return Center(child: Text("No favorites yet."));
    // }
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Cruces Chess Club is a local non-profit organization.  We meet every Wednesday at 7pm at a different location each week."),
            SizedBox(height: 10),
            Text(
              "Our Mission",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Colors.blueGrey[700],
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Our mission is to foster a vibrant and inclusive community centered around the enjoyment of chess. "
              "We are dedicated to supporting our members by providing high-quality chess boards, timers, and resources, "
              "while also empowering them to participate in competitions and travel to events.",
              style: TextStyle(
                fontSize: 16,
                height: 1.5,
                color: Colors.grey[800],
              ),
            ),
            SizedBox(height: 20),
            Row(children: [
                Icon(Icons.picture_in_picture),
                Icon(Icons.facebook),
                Icon(Icons.web)
            ],)
          ],
        ),
      );      
  }
}
