import 'package:dictionary_app/screens/splash_screen.dart';
import 'package:dictionary_app/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Supabase.initialize(
    url: 'https://fzwsjzldxosnnoszixuu.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYW5vbiIsImlhdCI6MTYyODA0MjYyMiwiZXhwIjoxOTQzNjE4NjIyfQ.cUpbh-foLuNxGlD_goEwq1wruNuXCLefTunwgBF08r0',
    authCallbackUrlHostname: 'login-callback',
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(
          statusBarColor: Color(0xFFCD0916),
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.light),
    );
    return ProviderScope(
      child: MaterialApp(
        theme: theme,
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
