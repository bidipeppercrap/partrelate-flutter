// ignore_for_file: avoid_manual_providers_as_generated_provider_dependency
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'prefs.g.dart';

@riverpod
String authToken(AuthTokenRef ref) {
  final preferences = ref.watch(sharedPreferencesProvider);
  final currentValue = preferences.getString('auth_token') ?? '';

  ref.listenSelf((prev, curr) {
    preferences.setString('auth_token', curr);
  });

  return currentValue;
}

@riverpod
SharedPreferences sharedPreferences(SharedPreferencesRef ref) {
  throw UnimplementedError();
}