import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StatusProvider extends ChangeNotifier {
  int _status;
  set status(val) {
    _status = val;
  }

  int get status => _status;

  void listenToStatus(int status) {
    _status = status;

    notifyListeners();
  }
}

final statusNotifier = ChangeNotifierProvider(
  (_) => StatusProvider(),
);
