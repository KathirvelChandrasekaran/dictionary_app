import 'package:dictionary_app/utils/constantes.dart';
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

  getUserBookmark() async {
    final response = await manager.client
        .from('bookmarks')
        .select()
        .eq('createdBy', supabase.auth.currentUser.email)
        .order('createdAt', ascending: true)
        .execute();
    final resData = response.data as List;
    return resData;
  }
}
