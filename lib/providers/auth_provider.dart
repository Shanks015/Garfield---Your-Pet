import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flowday/providers/supabase_provider.dart';
import 'package:flowday/services/sync_service.dart';

final authStateProvider = StreamProvider<User?>((ref) {
  final supabase = ref.watch(supabaseClientProvider);
  
  return supabase.auth.onAuthStateChange.map((data) {
    final user = data.session?.user;
    if (user != null && (data.event == AuthChangeEvent.signedIn || data.event == AuthChangeEvent.tokenRefreshed)) {
      // Trigger database sync in background on successful authentication
      ref.read(syncServiceProvider).syncAll(user.id);
    }
    return user;
  });
});

final currentUserProvider = Provider<User?>((ref) {
  return ref.watch(authStateProvider).value;
});
