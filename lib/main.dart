import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import './app.dart';
import './state.dart';
import './widgets/schedule.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  // await Firebase.initializeApp();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  print("Handling a background message: ${message.messageId}");
  print("Handling a background message: ${message.data}");
  // await updateState(context);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final notificationSettings = await FirebaseMessaging.instance
      .requestPermission(provisional: true);
  await FirebaseMessaging.instance.subscribeToTopic("calendar");
  print("subscribed to calendar topic");

  var date = DateTime.now();
  var start = getFirstDayOfTheMonth(date);
  var end = getLastDayOfTheMonth(DateTime(date.year, date.month + 2, 1));
  final appState = await fetchSchedule(start, end);
  runApp(Provider.value(value: appState, child: MyApp()));

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Cruces Chess Club',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.green[900]!,
            brightness: Brightness.dark,
          ),
          brightness: Brightness.dark,
        ),
        home: MyHomePage(),
      ),
    );
  }
}
