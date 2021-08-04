import 'package:dictionary_app/screens/home.dart';
import 'package:dictionary_app/screens/sign_up.dart';
import 'package:dictionary_app/utils/supabase_manager.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key key}) : super(key: key);

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  void initState() {
    super.initState();
    checkSession();
  }

  void checkSession() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final session = sharedPreferences.getString('user');

    if (session == null)
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => AuthScreen(),
        ),
      );
    else {
      final response =
          await SupabaseManager().client.auth.recoverSession(session);
      sharedPreferences.setString('user', response.data.persistSessionString);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Home(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
