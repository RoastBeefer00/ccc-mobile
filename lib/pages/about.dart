import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state.dart';
import '../colors.dart';

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                fontWeight: FontWeight.w700,
                color: ThemeColors.greensDarkest,
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
            Row(
            mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.picture_in_picture, color: ThemeColors.greensDarkest, size: 30,),
                Icon(Icons.facebook, color: ThemeColors.greensDarkest, size: 30,),
                Icon(Icons.web, color: ThemeColors.greensDarkest, size: 30,)
            ],)
          ],
        ),
      );      
  }
}
