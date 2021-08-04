import 'package:dictionary_app/utils/supabase_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase/supabase.dart';

class AuthService {
  SupabaseManager manager = SupabaseManager();

  Future<GotrueSessionResponse> signUp(String email, String password) async {
    var response = await manager.client.auth.signUp(email, password);
    final sharedPreference = await SharedPreferences.getInstance();
    sharedPreference.setString('user', response.data.persistSessionString);
    print(response.user);
    return response;
  }

  Future<GotrueSessionResponse> signIn(String email, String password) async {
    var response =
        await manager.client.auth.signIn(email: email, password: password);
    final sharedPreference = await SharedPreferences.getInstance();
    sharedPreference.setString('user', response.data.persistSessionString);
    return response;
  }
}
