import 'package:dictionary_app/utils/supabase_manager.dart';
import 'package:supabase/supabase.dart';

class AuthService {
  SupabaseManager manager = SupabaseManager();
  Future<GotrueSessionResponse> signUp(String email, String password) async {
    var response = await manager.client.auth.signUp(email, password);
    print(response.runtimeType);
    return response;
  }

  Future<GotrueSessionResponse> signIn(String email, String password) async {
    var response =
        await manager.client.auth.signIn(email: email, password: password);
    return response;
  }
}
