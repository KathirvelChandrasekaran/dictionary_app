import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:dictionary_app/services/bookmark_service.dart';
import 'package:dictionary_app/utils/supabase_manager.dart';
import 'package:dictionary_app/widgets/word_with_icons.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase/supabase.dart';

class SavedWords extends StatefulWidget {
  const SavedWords({Key key}) : super(key: key);

  @override
  _SavedWordsState createState() => _SavedWordsState();
}

class _SavedWordsState extends State<SavedWords> {
  GotrueSessionResponse _response;
  @override
  void initState() {
    super.initState();
    getSharedPreferences();
  }

  getSharedPreferences() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final session = sharedPreferences.getString('user');
    final response =
        await SupabaseManager().client.auth.recoverSession(session);
    _response = response;
    print(_response.user.email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Saved words"),
      ),
      backgroundColor: Theme.of(context).accentColor,
      body: FutureBuilder(
        future: BookMarkService().getUserBookmark(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData == null &&
              snapshot.connectionState == ConnectionState.none)
            return Center(
              child: CircularProgressIndicator(),
            );
          return ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 15.0,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 25,
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Container(
                        child: Text(
                          snapshot.data[index]['word'],
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Container(
                        child: Text(
                          snapshot.data[index]['defenition'],
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
