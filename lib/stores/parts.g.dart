// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parts.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$partsRepositoryHash() => r'91e60cbc6b2cdc0603c193bd97370967ceaa7200';

/// See also [partsRepository].
@ProviderFor(partsRepository)
final partsRepositoryProvider = AutoDisposeProvider<PartsRepository>.internal(
  partsRepository,
  name: r'partsRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$partsRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef PartsRepositoryRef = AutoDisposeProviderRef<PartsRepository>;
String _$partsHash() => r'db3edbb991ebbffff051ef10daff9b62e03b6073';

/// See also [parts].
@ProviderFor(parts)
final partsProvider = AutoDisposeProvider<List<Part>>.internal(
  parts,
  name: r'partsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$partsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef PartsRef = AutoDisposeProviderRef<List<Part>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
