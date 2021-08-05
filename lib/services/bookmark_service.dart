import 'package:dictionary_app/utils/constantes.dart';
import 'package:dictionary_app/utils/supabase_manager.dart';

class BookMarkService {
  SupabaseManager manager = SupabaseManager();

  Future addBookMark(
      String word, meanaing, audioURL, phoenetics, partsOfSpeech) async {
    await manager.client.from('bookmarks').insert(
      {
        'createdBy': supabase.auth.currentUser.email,
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
    // print(response.data);
    final readData = response.data as List;
    return readData;
  }

  deleteBookMark(String id) async {
    await manager.client.from('bookmarks').delete().eq('id', id).execute();
  }
}
