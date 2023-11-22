// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicles.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$vehiclesRepositoryHash() =>
    r'4efeb4cf2762674b356c2ac02c8df9b30f05eea2';

/// See also [vehiclesRepository].
@ProviderFor(vehiclesRepository)
final vehiclesRepositoryProvider =
    AutoDisposeProvider<VehiclesRepository>.internal(
  vehiclesRepository,
  name: r'vehiclesRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$vehiclesRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef VehiclesRepositoryRef = AutoDisposeProviderRef<VehiclesRepository>;
String _$vehiclesHash() => r'17906cbdb1195150be318ac5c00578c5b8d2f64d';

/// See also [vehicles].
@ProviderFor(vehicles)
final vehiclesProvider = AutoDisposeProvider<List<Vehicle>>.internal(
  vehicles,
  name: r'vehiclesProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$vehiclesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef VehiclesRef = AutoDisposeProviderRef<List<Vehicle>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
