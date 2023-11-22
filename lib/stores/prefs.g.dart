// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prefs.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$authTokenHash() => r'b0deda877629e779d5a85ef29ffd573b67cba87f';

/// See also [authToken].
@ProviderFor(authToken)
final authTokenProvider = AutoDisposeProvider<String>.internal(
  authToken,
  name: r'authTokenProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$authTokenHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AuthTokenRef = AutoDisposeProviderRef<String>;
String _$sharedPreferencesHash() => r'5bd64b2e955a2adbe9af0a4cd3edab6923105998';

/// See also [sharedPreferences].
@ProviderFor(sharedPreferences)
final sharedPreferencesProvider =
    AutoDisposeProvider<SharedPreferences>.internal(
  sharedPreferences,
  name: r'sharedPreferencesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$sharedPreferencesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef SharedPreferencesRef = AutoDisposeProviderRef<SharedPreferences>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
