import 'package:dictionary_app/services/bookmark_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final bookMarkProvider = Provider(
  (_) => BookMarkService(),
);
