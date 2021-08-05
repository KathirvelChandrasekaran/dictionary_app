import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:dictionary_app/models/dictionay_model.dart';
import 'package:dictionary_app/utils/constantes.dart';
import 'package:dictionary_app/utils/snackBar.dart';
import 'package:dictionary_app/utils/supabase_manager.dart';
import 'package:dictionary_app/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share/share.dart';

Column wordWithIcons(AsyncData<List<DictionaryModel>> res, int index,
    BuildContext context, AssetsAudioPlayer assetAudioPlayer) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Center(
              child: Text(
                '${res.value[index].word}',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Container(
            child: Center(
              child: Text(
                '${res.value[index].phonetics.first.text}',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ],
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
                        ClipboardData(text: res.value[index].word),
                      ).then(
                        (value) => ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Text is copied to Clipboard ✌🏼"),
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Theme.of(context).primaryColor,
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
                        Audio.network(res.value[index].phonetics.first.audio),
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
          Consumer(builder: (context, watch, child) {
            return Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Container(
                    child: IconButton(
                      tooltip: "Save to bookmark",
                      onPressed: () async {
                        // final sharedPreferences =
                        //     await SharedPreferences.getInstance();
                        // final session = sharedPreferences.getString('user');
                        // await SupabaseManager()
                        //     .client
                        //     .auth
                        //     .recoverSession(session);

                        supabase.auth.currentSession != null
                            ? await SupabaseManager()
                                .client
                                .from('bookmarks')
                                .insert({
                                  'createdBy': supabase.auth.currentUser.email,
                                  'word': res.value[index].word,
                                  'meaning': res.value[index].meanings.first
                                      .definitions.first.definition,
                                  'audioURL':
                                      res.value[index].phonetics.first.audio,
                                  'phoenetics':
                                      res.value[index].phonetics.first.text,
                                  'partsOfSpeech': res
                                      .value[index].meanings.first.partOfSpeech,
                                })
                                .execute()
                                .then(
                                  (value) => createSnackBar(
                                      "Saved to your bookmark",
                                      context,
                                      theme.accentColor,
                                      theme.primaryColor),
                                )
                            : createSnackBar(
                                "Login to save",
                                context,
                                Theme.of(context).accentColor,
                                Theme.of(context).primaryColor,
                              );
                      },
                      icon: Icon(
                        Icons.bookmark_added_rounded,
                        color: Theme.of(context).indicatorColor,
                      ),
                    ),
                  ),
                  Text(
                    "Save",
                    style: TextStyle(
                      color: Theme.of(context).indicatorColor,
                    ),
                  )
                ],
              ),
            );
          }),
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
                        'Check out the word ${res.value.first.word} in Dictionary app!',
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
  );
}
