import 'package:dictionary_app/providers/dictionary_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void createSnackBar(String message) {
      final snackBar = new SnackBar(
        content: new Text(
          message,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return Consumer(builder: (context, watch, child) {
      var queryListener = watch(queryProvider);
      var response = watch(getQueryResponse(queryListener.query));
      return Scaffold(
        body: FloatingSearchBar(
          hint: 'Search word',
          scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
          transitionDuration: const Duration(milliseconds: 800),
          transitionCurve: Curves.easeInOut,
          physics: const BouncingScrollPhysics(),
          axisAlignment: isPortrait ? 0.0 : -1.0,
          openAxisAlignment: 0.0,
          width: isPortrait ? 600 : 500,
          debounceDelay: const Duration(milliseconds: 100),
          onQueryChanged: (val) {},
          clearQueryOnClose: false,
          transition: CircularFloatingSearchBarTransition(),
          onSubmitted: (val) {
            if (val == "") {
              print(val);
              createSnackBar("Please enter keyword to find meaning ✌🏼");
              queryListener.listenFlag = true;
              return;
            } else {
              queryListener.query = val.toString();
              queryListener.listenFlag = true;
              watch(getQueryResponse(queryListener.query));
            }
          },
          actions: [
            FloatingSearchBarAction(
              showIfOpened: false,
              child: CircularButton(
                  icon: const Icon(
                    Icons.search_rounded,
                  ),
                  onPressed: () {}),
            ),
            FloatingSearchBarAction.searchToClear(
              showIfClosed: false,
            ),
          ],
          builder: (context, transition) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Material(
                color: Colors.white,
                elevation: 4.0,
                child: Column(),
              ),
            );
          },
          body: Container(
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.10),
            child: queryListener.listenFlag
                ? Consumer(
                    builder: (context, watch, child) {
                      return Container(
                        child: response.map(
                          data: (res) {
                            AssetsAudioPlayer assetAudioPlayer =
                                AssetsAudioPlayer();
                            return ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: res.value.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Container(
                                    padding: const EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(
                                        15,
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              '${res.value[index].word}',
                                              style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 26,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 15,
                                            ),
                                            Text(
                                              '${res.value[index].phonetics.isEmpty ? "" : res.value[index].phonetics.first.text}',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 15,
                                            ),
                                            res.value[index].phonetics
                                                    .isNotEmpty
                                                ? IconButton(
                                                    onPressed: () {
                                                      print(res
                                                          .value[index]
                                                          .phonetics
                                                          .first
                                                          .audio);
                                                      assetAudioPlayer.open(
                                                        Audio.network(res
                                                            .value[index]
                                                            .phonetics
                                                            .first
                                                            .audio),
                                                      );
                                                    },
                                                    icon: Icon(
                                                      Icons.volume_up_rounded,
                                                      color: Colors.red,
                                                    ),
                                                  )
                                                : Text("")
                                          ],
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                          '${res.value[index].meanings.isEmpty ? "" : res.value[index].meanings.first.partOfSpeech}',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                          "Defenition",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          '${res.value[index].meanings.isEmpty ? "" : res.value[index].meanings.first.definitions.first.definition}',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          loading: (_) => SizedBox(
                            child: Text("Loading"),
                          ),
                          error: (_) {
                            return Text(
                              _.error.toString(),
                              style: TextStyle(
                                color: Colors.red,
                              ),
                            );
                          },
                        ),
                      );
                    },
                  )
                : Center(
                    child: Text(
                      'Please provide word to see meaning',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
          ),
        ),
      );
    });
  }
}
