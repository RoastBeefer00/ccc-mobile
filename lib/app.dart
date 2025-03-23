import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './pages/home.dart';
import './pages/about.dart';
import './state.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;

  @override
      initState() {
          super.initState();
          var appState = context.read<MyAppState>();
          appState.updateSchedule();
      }

  @override
  Widget build(BuildContext context) {
    // var appState = context.watch<MyAppState>();
    // appState.updateSchedule();
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = HomePage();
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

    var destinations = [
      NavigationDestination(
        icon: Icon(Icons.home, color: Theme.of(context).colorScheme.onPrimary),
        label: "Home",
      ),
      NavigationDestination(
        icon: Icon(
          Icons.people,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        label: "About Us",
      ),
      NavigationDestination(
        icon: Icon(
          Icons.calendar_month,
          color: Theme.of(context).colorScheme.onPrimary,
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
                color: theme.colorScheme.onPrimaryContainer,
              ),
            ),
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            // leading: Builder(builder: (context) {
            //     return IconButton(
            //      icon: Icon(Icons.menu, color: theme.colorScheme.onPrimary,),
            //      onPressed: () {
            //          Scaffold.of(context).openDrawer();
            //      },
            //     );
            // }),
          ),
          body: Center(
            child: Container(
              color: Theme.of(context).colorScheme.primary,
              child: page,
            ),
          ),
          bottomNavigationBar: NavigationBarTheme(
            data: NavigationBarThemeData(
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              indicatorColor: Theme.of(context).colorScheme.secondary,
              labelTextStyle: MaterialStateProperty.resolveWith<TextStyle>(
                (Set<MaterialState> states) => theme.textTheme.labelSmall!
                    .copyWith(color: theme.colorScheme.onPrimaryContainer),
              ),
            ),
            child: NavigationBar(
              onDestinationSelected: (int index) {
                _onItemTapped(index);
              },
              // backgroundColor: Theme.of(context).colorScheme.primary,
              // indicatorColor: Theme.of(context).colorScheme.tertiary,
              selectedIndex: selectedIndex,
              destinations: destinations,
            ),
          ),
          // drawer: Drawer(
          //   backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          //   child: ListView(
          //     padding: EdgeInsets.zero,
          //     children: [
          //       DrawerHeader(decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary), child: Text("CCC")),
          //       ListTile(
          //         leading: Icon(Icons.home),
          //         title: const Text("Home"),
          //         selected: selectedIndex == 0,
          //         onTap: () {
          //             setState(() {
          //               _onItemTapped(0);
          //               Navigator.pop(context);
          //             });
          //         },
          //       ),
          //       ListTile(
          //         leading: Icon(Icons.people),
          //         title: const Text("About Us"),
          //         selected: selectedIndex == 1,
          //         onTap: () {
          //           setState(() {
          //             _onItemTapped(1);
          //             Navigator.pop(context);
          //           });
          //         },
          //       ),
          //       ListTile(
          //         leading: Icon(Icons.calendar_month),
          //         title: const Text("Schedule"),
          //         selected: selectedIndex == 2,
          //         onTap: () {
          //           setState(() {
          //             _onItemTapped(2);
          //             Navigator.pop(context);
          //           });
          //         },
          //       ),
          //     ],
          //   ),
          // ),
        );
      },
    );
  }
}
