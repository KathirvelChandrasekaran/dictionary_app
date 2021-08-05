import 'package:dictionary_app/services/dictionary_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dictionary_app/models/dictionay_model.dart';
import 'package:dictionary_app/models/error_model.dart';

class DictionoryNotifier extends ChangeNotifier {
  String _query = "";
  bool _listenFlag = false;
  String get query => _query;
  bool get listenFlag => _listenFlag;

  set query(value) {
    _query = value;
  }

  set listenFlag(value) {
    _listenFlag = value;
  }

  void listenToQuery(String query) {
    _query = query;

    notifyListeners();
  }

  void listenToFlag(bool flag) {
    _listenFlag = flag;

    notifyListeners();
  }
}

final queryProvider = ChangeNotifierProvider(
  (_) => DictionoryNotifier(),
);

final dictionaryProvider = Provider(
  (_) => DictionaryService(),
);

final errorProvider = Provider(
  (_) => ErrorService(),
);

final getQueryResponse =
    FutureProvider.autoDispose.family<List<DictionaryModel>, String>(
  (ref, query) {
    final res = ref.read(dictionaryProvider);
    return res.get(query);
  },
);

final getErrorResponse = FutureProvider.autoDispose.family<ErrorModel, String>(
  (ref, query) {
    final res = ref.read(errorProvider);
    return res.get(query);
  },
);
