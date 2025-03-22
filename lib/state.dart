import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import './widgets/schedule.dart';

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();
  // late Future<ClubEvent> schedule;
  //
  // void setSchedule() {
  //   // super.initState();
  //   schedule = fetchSchedule();
  // }

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
