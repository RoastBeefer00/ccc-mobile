import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../state.dart';
import '../colors.dart';

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    "Cruces Chess Club is a local non-profit organization.  We meet every Wednesday at a different location each week.",
                  textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      height: 1.5,
                      color: ThemeColors.whitesOffWhite,
                    ),
                ),
                SizedBox(height: 10),
                Text(
                  "Our Mission",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w700,
                    color: ThemeColors.chessGreenLight,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Our mission is to foster a vibrant and inclusive community centered around the enjoyment of chess. "
                  "We are dedicated to supporting our members by providing high-quality chess boards, timers, and resources, "
                  "while also empowering them to participate in competitions and travel to events.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    height: 1.5,
                    color: ThemeColors.whitesOffWhite,
                  ),
                ),
                SizedBox(height: 20),
                Row(
                mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(FontAwesomeIcons.instagram, color: ThemeColors.chessGreenLight, size: 36,),
                    SizedBox(width: 16),
                    Icon(Icons.facebook, color: ThemeColors.chessGreenLight, size: 36,),
                    SizedBox(width: 16),
                    Icon(Icons.language, color: ThemeColors.chessGreenLight, size: 36,)
                ],)
              ],
            ),
          ),
        ),
    );      
  }
}
