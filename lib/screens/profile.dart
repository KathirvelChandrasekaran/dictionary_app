import 'package:dictionary_app/screens/splash_screen.dart';
import 'package:dictionary_app/utils/constantes.dart';
import 'package:dictionary_app/utils/snackBar.dart';
import 'package:dictionary_app/utils/supabase_manager.dart';
import 'package:flutter/material.dart';

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
              final response = await supabase.auth.signOut();
              if (response.error != null)
                createSnackBar(
                  response.error.message,
                  context,
                  Theme.of(context).primaryColor,
                  Theme.of(context).accentColor,
                );
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
      body: Center(
        child: Text(
          supabase.auth.currentUser.email,
          style: TextStyle(
            color: Theme.of(context).accentColor,
            fontSize: 25,
          ),
        ),
      ),
    );
  }
}
