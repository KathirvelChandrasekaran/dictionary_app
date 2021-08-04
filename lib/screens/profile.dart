import 'package:dictionary_app/screens/splash_screen.dart';
import 'package:dictionary_app/utils/supabase_manager.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  const Profile({Key key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  SupabaseManager manager = SupabaseManager();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
          style: TextStyle(
            color: Theme.of(context).accentColor,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              final sharedPreference = await SharedPreferences.getInstance();
              sharedPreference.clear();
              await manager.client.auth.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => SplashScreen(),
                ),
              );
            },
            icon: Icon(
              Icons.logout_rounded,
              color: Theme.of(context).accentColor,
            ),
          ),
        ],
      ),
    );
  }
}
