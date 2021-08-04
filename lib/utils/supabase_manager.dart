import 'package:supabase/supabase.dart';

const supabaseURL = "https://fzwsjzldxosnnoszixuu.supabase.co";
const supabaseKey =
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYW5vbiIsImlhdCI6MTYyODA0MjYyMiwiZXhwIjoxOTQzNjE4NjIyfQ.cUpbh-foLuNxGlD_goEwq1wruNuXCLefTunwgBF08r0";

class SupabaseManager {
  final client = SupabaseClient(supabaseURL, supabaseKey);
}
