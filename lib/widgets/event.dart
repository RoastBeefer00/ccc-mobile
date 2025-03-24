import 'package:flutter/material.dart';
import 'package:maps_launcher/maps_launcher.dart';

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
    final theme = Theme.of(context);
    final nameStyle = theme.textTheme.headlineMedium!.copyWith(
      color: theme.colorScheme.onPrimaryContainer,
      fontWeight: FontWeight.bold,
    );
    final numStyle = theme.textTheme.titleLarge!.copyWith(
      color: theme.colorScheme.onPrimaryContainer,
    );
    final monthStyle = theme.textTheme.titleMedium!.copyWith(
      color: theme.colorScheme.onPrimaryContainer,
    );
    final locationStyle = theme.textTheme.labelMedium!.copyWith(
      color: theme.colorScheme.onPrimaryContainer,
    );

    return Card(
      elevation: 5,
      color: theme.colorScheme.primaryContainer,
      child: ListTile(
        leading: Container(
          width: 100,
          child: Column(
            children: [
              Text("${date.day}", style: numStyle),
              Text(monthAsString(date.month), style: monthStyle),
            ],
          ),
        ),
        title: Column(
          children: [
            Text(name, style: nameStyle),
            Divider(color: theme.colorScheme.onPrimaryContainer),
          ],
        ),
        subtitle: Column(
          children: [
            if (location != null) Text(location!, style: locationStyle),
          ],
        ),
        trailing:
            (location != null)
                ? ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.secondary,
                    foregroundColor: theme.colorScheme.onSecondary,
                  ),
                  onPressed: () {
                    MapsLauncher.launchQuery(location!);
                  },
                  child: Icon(Icons.directions),
                )
                : null,
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
