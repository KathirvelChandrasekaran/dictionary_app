import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:dictionary_app/screens/splash_screen.dart';
import 'package:dictionary_app/services/bookmark_service.dart';
import 'package:dictionary_app/utils/constantes.dart';
import 'package:dictionary_app/utils/snackBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share/share.dart';

class SavedWords extends StatefulWidget {
  const SavedWords({Key key}) : super(key: key);

  @override
  _SavedWordsState createState() => _SavedWordsState();
}

class _SavedWordsState extends State<SavedWords> {
  BookMarkService _bookMarkService;
  AssetsAudioPlayer assetAudioPlayer;
  @override
  void initState() {
    super.initState();
    _bookMarkService = BookMarkService();
    assetAudioPlayer = AssetsAudioPlayer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Saved words"),
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
      backgroundColor: Theme.of(context).accentColor,
      body: FutureBuilder(
        future: _bookMarkService.getUserBookmark(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
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
                          snapshot.data[index]['meaning'],
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  child: IconButton(
                                    tooltip: "Copy to Clipboard",
                                    onPressed: () {
                                      Clipboard.setData(
                                        ClipboardData(
                                            text: snapshot.data[index]['word']),
                                      ).then(
                                        (value) => ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                                "Text is copied to Clipboard ✌🏼"),
                                            behavior: SnackBarBehavior.floating,
                                            backgroundColor:
                                                Theme.of(context).primaryColor,
                                          ),
                                        ),
                                      );
                                    },
                                    icon: Icon(
                                      Icons.copy_rounded,
                                      color: Theme.of(context).indicatorColor,
                                    ),
                                  ),
                                ),
                                Text(
                                  "Copy",
                                  style: TextStyle(
                                    color: Theme.of(context).indicatorColor,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  child: IconButton(
                                    tooltip: "Play pronounciation",
                                    onPressed: () {
                                      assetAudioPlayer.open(
                                        Audio.network(
                                            snapshot.data[index]['audioURL']),
                                      );
                                    },
                                    icon: Icon(
                                      Icons.volume_up_rounded,
                                      color: Theme.of(context).indicatorColor,
                                    ),
                                  ),
                                ),
                                Text(
                                  "Hear",
                                  style: TextStyle(
                                    color: Theme.of(context).indicatorColor,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  child: IconButton(
                                    tooltip: "Delete from saved list",
                                    onPressed: () async {
                                      await BookMarkService().deleteBookMark(
                                          snapshot.data[index]['id']);
                                      createSnackBar(
                                          "Deleted Successfully",
                                          context,
                                          Theme.of(context).accentColor,
                                          Theme.of(context).primaryColor);
                                    },
                                    icon: Icon(
                                      Icons.delete_forever_rounded,
                                      color: Theme.of(context).indicatorColor,
                                    ),
                                  ),
                                ),
                                Text(
                                  "Delete",
                                  style: TextStyle(
                                    color: Theme.of(context).indicatorColor,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  child: IconButton(
                                    tooltip: "Share this word",
                                    onPressed: () {
                                      Share.share(
                                        'Check out the word ${snapshot.data[index]['word']} in Dictionary app!',
                                        subject: 'Look what I made!',
                                      );
                                    },
                                    icon: Icon(
                                      Icons.share_rounded,
                                      color: Theme.of(context).indicatorColor,
                                    ),
                                  ),
                                ),
                                Text(
                                  "Share",
                                  style: TextStyle(
                                    color: Theme.of(context).indicatorColor,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
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
