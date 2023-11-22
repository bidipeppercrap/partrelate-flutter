import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:partrelate/stores/prefs.dart';

class SettingsRepository {
  const SettingsRepository(this.ref);
  final Ref ref;

  Uri getRouteUri(String route) {
    return Uri.parse('${serverUrl()}$route');
  }

  String serverUrl() {
    final prefs = ref.read(sharedPreferencesProvider);

    return prefs.getString('server_url') ?? '';
  }

  Future<void> setServerUrl(String url) {
    final prefs = ref.read(sharedPreferencesProvider);

    return prefs.setString('server_url', url);
  }

  String authToken() {
    final prefs = ref.read(sharedPreferencesProvider);

    return prefs.getString('auth_token') ?? '';
  }

  Future<void> setAuthToken(String token) {
    final prefs = ref.read(sharedPreferencesProvider);

    return prefs.setString('auth_token', token);
  }
}