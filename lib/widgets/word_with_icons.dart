import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:dictionary_app/models/dictionay_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Column wordWithIcons(AsyncData<List<DictionaryModel>> res, int index,
    BuildContext context, AssetsAudioPlayer assetAudioPlayer) {
  return Column(
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
                    onPressed: () {},
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
                    onPressed: () {},
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
                    onPressed: () {},
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
