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
          size: 30,
          color:
              (selectedIndex == 0)
                  ? ThemeColors.chessBlack
                  : ThemeColors.chessTan,
        ),
        label: "Home",
      ),
      NavigationDestination(
        icon: Icon(
          Icons.people,
          size: 30,
          color:
              (selectedIndex == 1)
                  ? ThemeColors.chessBlack
                  : ThemeColors.chessTan,
        ),
        label: "About Us",
      ),
      NavigationDestination(
        icon: Icon(
          Icons.calendar_month,
          size: 30,
          color:
              (selectedIndex == 2)
                  ? ThemeColors.chessBlack
                  : ThemeColors.chessTan,
        ),
        label: "Schedule",
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          appBar: AppBar(
            title: Center(
              child: Text(
                "Cruces Chess Club",
              style: TextStyle(fontFamily: 'Lora', fontSize: 32, color: ThemeColors.whitesOffWhite),
              ),
            ),
            backgroundColor: ThemeColors.chessBlack,
          ),
          body: Center(
            child: Container(
              color: ThemeColors.chessBlackBackground,
              child: page,
            ),
          ),
          bottomNavigationBar: NavigationBarTheme(
            data: NavigationBarThemeData(
            backgroundColor: ThemeColors.chessBlack,
              indicatorColor: ThemeColors.chessGreenLight,
              labelTextStyle: MaterialStateProperty.resolveWith<TextStyle>(
                (Set<MaterialState> states) => TextStyle(color: ThemeColors.whitesOffWhite, fontSize: 16)              
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
