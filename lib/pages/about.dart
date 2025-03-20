import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state.dart';

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
