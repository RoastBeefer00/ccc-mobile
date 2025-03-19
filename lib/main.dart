import 'dart:developer';

import 'package:english_words/english_words.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  // await Firebase.initializeApp();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final notificationSettings = await FirebaseMessaging.instance.requestPermission(provisional: true);

  print("Handling a background message: ${message.messageId}");
}

// void main() {
//   FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
//   runApp(MyApp());
// }

void main() {
    WidgetsFlutterBinding.ensureInitialized();
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // print("hello");
    // await Firebase.initializeApp(
    //         options: DefaultFirebaseOptions.currentPlatform,
    //         );
    // final notificationSettings = await FirebaseMessaging.instance.requestPermission(provisional: true);
    // final token = await FirebaseMessaging.instance.getToken();
    // print("Token: $token");

    runApp(const MyApp());
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
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();

  void getNext() {
      current = WordPair.random();
      notifyListeners();
  }

  var favorites = <WordPair>[];

  void toggleFavorite() {
      if (favorites.contains(current)) {
          favorites.remove(current);
      } else {
          favorites.add(current);
      }
      notifyListeners();
  }

  void removeFavorite(WordPair fav) {
    favorites.remove(fav);
    notifyListeners();
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = GeneratorPage();
        // break;
      case 1:
        page = FavoritesPage();
        // break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }
    void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          appBar: AppBar(
           title: Text("Cruces Chess Club"), 
           leading: Builder(builder: (context) {
               return IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                    Scaffold.of(context).openDrawer();
                },
               );
           }),
          ),
          body: Center(
            child: Container(
              color: Theme.of(context).colorScheme.primaryContainer,
              child: page,
            ),
          ),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                const DrawerHeader(decoration: BoxDecoration(color: Colors.teal), child: Text("CCC")),
                ListTile(
                  leading: Icon(Icons.home),
                  title: const Text("Home"),
                  selected: selectedIndex == 0,
                  onTap: () {
                      setState(() {
                        _onItemTapped(0);
                        Navigator.pop(context);
                      });
                  },
                ),
                ListTile(
                  leading: Icon(Icons.favorite),
                  title: const Text("Favorites"),
                  selected: selectedIndex == 1,
                  onTap: () {
                      setState(() {
                        _onItemTapped(1);
                        Navigator.pop(context);
                      });
                  },
                )
              ],
            ),
          ),
        );
      }
    );
  }
}


class GeneratorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.current;

    IconData icon;
    if (appState.favorites.contains(pair)) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BigCard(pair: pair),
          SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  appState.toggleFavorite();
                },
                icon: Icon(icon),
                label: Text('Like'),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  appState.getNext();
                },
                child: Text('Next'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

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
      if (appState.favorites.isEmpty) {
          return Center(child: Text("No favorites yet."),);
      }
      return ListView(
        children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                "You have ${appState.favorites.length} favorites:", 
                style: headerStyle
              ),
            ),
            for (var fav in appState.favorites)
                ListTile(leading: Icon(Icons.favorite), title: Text(fav.asLowerCase, style: listStyle,), onTap: () {appState.removeFavorite(fav);},)
        ],
      );
    }
}

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
        color: theme.colorScheme.onPrimary,
    );

    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(pair.asLowerCase, style: style, semanticsLabel: "${pair.first} ${pair.second}",),
    ));
  }
}

