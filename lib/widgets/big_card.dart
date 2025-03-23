import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  const EventCard({super.key, required this.name, required this.date, required this.location});

  final String name;
  final DateTime date;
  final String? location;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final nameStyle = theme.textTheme.titleLarge!.copyWith(
      color: theme.colorScheme.onPrimaryContainer,
    );
    final numStyle = theme.textTheme.displaySmall!.copyWith(
      color: theme.colorScheme.onPrimaryContainer,
    );
    final monthStyle = theme.textTheme.labelMedium!.copyWith(
      color: theme.colorScheme.onPrimaryContainer,
    );
    final locationStyle = theme.textTheme.labelMedium!.copyWith(
      color: theme.colorScheme.onPrimaryContainer,
    );

    return Card(
      color: theme.colorScheme.primaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Column(
              children: [
                Text("${date.day}", style: numStyle),
                Text(monthAsString(date.month), style: monthStyle),
              ],
            ),
            Column(
              children: [
                Text(name, style: nameStyle),
                if (location != null)
                    Text(location!, style: locationStyle),
              ],
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
