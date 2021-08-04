import 'package:dictionary_app/services/auth_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authServiceProvider = Provider(
  (_) => AuthService(),
);
