import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './pages/home.dart';
import './pages/about.dart';
import './pages/schedule.dart';
import './state.dart';
import './colors.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

var colors = ThemeColors.colors;

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  var selectedIndex = 0;

  @override
  initState() {
    super.initState();
    var appState = context.read<MyAppState>();
    appState.updateSchedule();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print("app state changed: $state");
    // This method is called when the app's lifecycle state changes
    if (state == AppLifecycleState.resumed) {
        print("app resumed");
      // Update state or perform actions when the app is resumed
      var appState = context.read<MyAppState>();
      appState.updateSchedule();
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = HomePage();
      case 1:
        page = FavoritesPage();
      case 2:
        page = SchedulePage();
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }
    void _onItemTapped(int index) {
      setState(() {
        selectedIndex = index;
      });
    }

    var destinations = [
      NavigationDestination(
        icon: Icon(
          Icons.home,
          color:
              (selectedIndex == 0)
                  ? ThemeColors.chessGreen
                  : ThemeColors.chessTan,
        ),
        label: "Home",
      ),
      NavigationDestination(
        icon: Icon(
          Icons.people,
          color:
              (selectedIndex == 1)
                  ? ThemeColors.chessGreen
                  : ThemeColors.chessTan,
        ),
        label: "About Us",
      ),
      NavigationDestination(
        icon: Icon(
          Icons.calendar_month,
          color:
              (selectedIndex == 2)
                  ? ThemeColors.chessGreen
                  : ThemeColors.chessTan,
        ),
        label: "Schedule",
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final theme = Theme.of(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Cruces Chess Club",
              style: theme.textTheme.headlineSmall!.copyWith(
                color: ThemeColors.chessTan,
              ),
            ),
            backgroundColor: ThemeColors.chessGreen,
          ),
          body: Center(
            child: Container(
              color: ThemeColors.chessTan,
              child: page,
            ),
          ),
          bottomNavigationBar: NavigationBarTheme(
            data: NavigationBarThemeData(
              backgroundColor: ThemeColors.chessGreen,
              indicatorColor: ThemeColors.greensLight,
              labelTextStyle: MaterialStateProperty.resolveWith<TextStyle>(
                (Set<MaterialState> states) => theme.textTheme.labelSmall!
                    .copyWith(color: ThemeColors.greensLight),
              ),
            ),
            child: NavigationBar(
              onDestinationSelected: (int index) {
                _onItemTapped(index);
              },
              selectedIndex: selectedIndex,
              destinations: destinations,
            ),
          ),
        );
      },
    );
  }
}
