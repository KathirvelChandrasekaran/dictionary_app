import 'package:dictionary_app/utils/supabase_manager.dart';

class BookMarkService {
  SupabaseManager manager = SupabaseManager();

  Future addBookMark(String createdBy, word, meanaing, audioURL, phoenetics,
      partsOfSpeech) async {
    await manager.client.from('bookmarks').insert(
      {
        'createdBy': createdBy,
        'word': word,
        'meanaing': meanaing,
        'audioURL': audioURL,
        'phoenetics': phoenetics,
        'partsOfSpeech': partsOfSpeech,
      },
    ).execute();
  }
}
