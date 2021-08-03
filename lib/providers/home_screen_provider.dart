import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreenNotifier extends ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  set currentIndex(val) {
    _currentIndex = val;
  }

  void listenToIndex(int index) {
    _currentIndex = index;

    notifyListeners();
  }
}

final indexProvider = ChangeNotifierProvider(
  (_) => HomeScreenNotifier(),
);
