import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:dictionary_app/providers/auto_fill_provider.dart';
import 'package:dictionary_app/providers/dictionary_provider.dart';
import 'package:dictionary_app/providers/status_provider.dart';
import 'package:dictionary_app/screens/login.dart';
import 'package:dictionary_app/utils/constantes.dart';
import 'package:dictionary_app/widgets/word_with_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key key}) : super(key: key);

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
        backgroundColor: Theme.of(context).primaryColor,
        behavior: SnackBarBehavior.floating,
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return Consumer(
      builder: (context, watch, child) {
        var queryListener = watch(queryProvider);
        var autoFillListener = watch(autoFillQueryProvider);
        var response = watch(getQueryResponse(queryListener.query));
        var autoResponse = watch(getAutoFillResponse(autoFillListener.query));
        FloatingSearchBarController controller = FloatingSearchBarController();
        print("From consumer");
        print(StatusProvider().status);
        return Scaffold(
          backgroundColor: Theme.of(context).primaryColor,
          appBar: AppBar(
            title: Text(
              "Dictionary App".toUpperCase(),
            ),
            backgroundColor: Theme.of(context).primaryColor,
            elevation: 0,
            actions: [
              supabase.auth.currentSession != null
                  ? IconButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginPage(),
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.login_outlined,
                        color: Theme.of(context).accentColor,
                      ),
                    )
                  : Container(),
            ],
          ),
          body: Container(
            margin: EdgeInsets.only(top: 10),
            child: FloatingSearchBar(
              controller: controller,
              borderRadius: BorderRadius.circular(15),
              hint: 'Search word',
              scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
              transitionDuration: const Duration(milliseconds: 100),
              transitionCurve: Curves.easeInOut,
              physics: const BouncingScrollPhysics(),
              axisAlignment: isPortrait ? 0.0 : -1.0,
              openAxisAlignment: 0.0,
              width: isPortrait ? 600 : 500,
              debounceDelay: const Duration(milliseconds: 100),
              onQueryChanged: (val) {
                autoFillListener.query = val;
                watch(getAutoFillResponse(autoFillListener.query));
                watch(getErrorResponse(queryListener.query));
              },
              clearQueryOnClose: false,
              transition: CircularFloatingSearchBarTransition(),
              onSubmitted: (val) {
                if (val == "") {
                  print(val);
                  controller.close();
                  createSnackBar("Please enter keyword to find meaning ✌🏼");
                  queryListener.listenFlag = true;
                  return;
                } else {
                  queryListener.query = val.toString();
                  queryListener.listenFlag = true;
                  watch(getQueryResponse(queryListener.query));
                  watch(getErrorResponse(queryListener.query));
                  controller.close();
                  // createSnackBar(
                  //     "${response.data.value.length} results for you");
                }
              },
              actions: [
                FloatingSearchBarAction(
                  showIfOpened: false,
                  child: CircularButton(
                    icon: const Icon(
                      Icons.search_rounded,
                    ),
                    onPressed: () {
                      queryListener.listenFlag = true;
                      watch(getQueryResponse(queryListener.query));
                      watch(getErrorResponse(queryListener.query));
                      controller.close();
                    },
                  ),
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
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      child: autoResponse.map(
                        data: (data) => ListView.builder(
                          itemCount: autoResponse.data.value.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(
                                data.value[index].word,
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                              onTap: () {
                                queryListener.listenFlag = true;
                                queryListener.query = data.value[index].word;
                                controller.close();
                              },
                            );
                          },
                        ),
                        loading: (_) => SizedBox(
                          child: Center(
                            child: Container(
                              height: 25,
                              width: 25,
                              child: CircularProgressIndicator(
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                        ),
                        error: (_) => Text(
                          _.error.toString(),
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
              body: Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.11),
                decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
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
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Container(
                                        margin: const EdgeInsets.all(10),
                                        padding: const EdgeInsets.all(20),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(20),
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
                                            wordWithIcons(res, index, context,
                                                assetAudioPlayer),
                                            SizedBox(
                                              height: 25,
                                            ),
                                            Container(
                                              child: Text(
                                                '${res.value[index].meanings.isEmpty ? "" : res.value[index].meanings.first.partOfSpeech}',
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
                                                '${res.value[index].meanings.isEmpty ? "" : res.value[index].meanings.first.definitions.first.definition}',
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
                              loading: (_) => SizedBox(
                                child: Center(
                                  child: Container(
                                    height: 25,
                                    width: 25,
                                    child: CircularProgressIndicator(
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                ),
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
                          'Please enter word to see meaning',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
              ),
            ),
          ),
        );
      },
    );
  }
}
