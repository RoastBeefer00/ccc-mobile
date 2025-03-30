import 'package:flutter/material.dart';
import 'package:maps_launcher/maps_launcher.dart';
import '../colors.dart';

class EventCard extends StatelessWidget {
  const EventCard({
    super.key,
    required this.name,
    required this.date,
    required this.location,
  });

  final String name;
  final DateTime date;
  final String? location;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(
          decoration: BoxDecoration(
            color: ThemeColors.whitesOffWhite,
            borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: ThemeColors.greensDark,
              offset: Offset(0, 2),
              blurRadius: 2,
            ),
          ],
          ),
          child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    Text("${monthAsStringLong(date.month)} 13th, 7:00pm", style: TextStyle(color: ThemeColors.blacksText, fontSize: 16, fontWeight: FontWeight.w500)),
                    Text("Amaro Winery", style: TextStyle(fontFamily: 'Lora', fontSize: 28, color: ThemeColors.greensDarkest)),
                    Divider(color: ThemeColors.greensDarkest, thickness: 2,),
                    if (location != null) InkWell(
                      highlightColor: ThemeColors.greensDark,
                      hoverColor: ThemeColors.greensDark,
                      splashColor: ThemeColors.greensDark,
                      focusColor: ThemeColors.greensDark,
                      onTap: () {
                        MapsLauncher.launchQuery(location!);
                      },
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // SizedBox(width: 8),
                          Flexible(child: Text(location!, style: TextStyle(color: ThemeColors.blacksText, fontSize: 16, fontWeight: FontWeight.w500), maxLines: 2,)),
                          Icon(Icons.directions, color: ThemeColors.greensDark, size: 38,),
                        ],
                      ),
                    ),
                ],
            ),
          ),
      ),
    );
    // return Card(
    //   elevation: 5,
    //   color: ThemeColors.greensPrimary,
    //   child: ListTile(
    //     leading: Container(
    //       width: 100,
    //       child: Column(
    //         children: [
    //           Text("${date.day}", style: numStyle),
    //           Text(monthAsString(date.month), style: monthStyle),
    //         ],
    //       ),
    //     ),
    //     title: Column(
    //       children: [
    //         Text(name, style: nameStyle),
    //         Divider(color: theme.colorScheme.onPrimaryContainer),
    //       ],
    //     ),
    //     subtitle: Column(
    //       children: [
    //         if (location != null) Text(location!, style: locationStyle),
    //       ],
    //     ),
    //     trailing:
    //         (location != null)
    //             ? ElevatedButton(
    //               style: ElevatedButton.styleFrom(
    //                 backgroundColor: ThemeColors.greensLight,
    //                 foregroundColor: ThemeColors.blacksText,
    //               ),
    //               onPressed: () {
    //                 MapsLauncher.launchQuery(location!);
    //               },
    //               child: Icon(Icons.directions),
    //             )
    //             : null,
    //   ),
    // );
  }
}

String monthAsString(int month) {
  switch (month) {
    case 1:
      return "Jan";
    case 2:
      return "Feb";
    case 3:
      return "Mar";
    case 4:
      return "Apr";
    case 5:
      return "May";
    case 6:
      return "Jun";
    case 7:
      return "Jul";
    case 8:
      return "Aug";
    case 9:
      return "Sep";
    case 10:
      return "Oct";
    case 11:
      return "Nov";
    case 12:
      return "Dec";
    default:
      throw UnimplementedError("monthAsString($month)");
  }
}

String monthAsStringLong(int month) {
  switch (month) {
    case 1:
      return "January";
    case 2:
      return "February";
    case 3:
      return "March";
    case 4:
      return "April";
    case 5:
      return "May";
    case 6:
      return "June";
    case 7:
      return "July";
    case 8:
      return "August";
    case 9:
      return "September";
    case 10:
      return "October";
    case 11:
      return "November";
    case 12:
      return "December";
    default:
      throw UnimplementedError("monthAsStringLong($month)");
  }
}
