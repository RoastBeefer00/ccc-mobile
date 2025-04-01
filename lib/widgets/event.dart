import 'package:flutter/material.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:intl/intl.dart';
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
      padding: const EdgeInsets.all(8.0),
      child: Container(
          // color: ThemeColors.chessBlack,
          decoration: BoxDecoration(
          color: ThemeColors.chessBlack,
          borderRadius: BorderRadius.circular(10),
          // boxShadow: [
          //   BoxShadow(
          //     color: ThemeColors.greensDark,
          //     offset: Offset(0, 2),
          //     blurRadius: 2,
          //   ),
          // ],
          ),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                  Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: ThemeColors.chessGreenLight,
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(DateFormat('MMMM dd, yyyy').add_jm().format(date), style: TextStyle(color: ThemeColors.chessBlack, fontWeight: FontWeight.w500), textAlign: TextAlign.center,),
                            Text(name, style: TextStyle(fontFamily: 'Lora', fontSize: 28, color: ThemeColors.chessBlack), textAlign: TextAlign.center,),
                          ],
                        ),
                      )
                  ),
                  // Divider(color: ThemeColors.chessBlack, thickness: 2,),
                  if (location != null) InkWell(
                    onTap: () {
                      MapsLauncher.launchQuery(location!);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Flexible(child: Text(location!, style: TextStyle(color: ThemeColors.whitesOffWhite, fontSize: 16, fontWeight: FontWeight.w500), maxLines: 2, textAlign: TextAlign.left,)),
                          SizedBox(width: 12),
                          Icon(Icons.directions, color: ThemeColors.chessGreenLight, size: 38,),
                        ],
                      ),
                    ),
                  ),
              ],
          ),
      ),
    );
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
