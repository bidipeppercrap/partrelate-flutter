import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../repositories/vehicles.dart';
import '../types/vehicle.dart';

part 'vehicles.g.dart';

@riverpod
VehiclesRepository vehiclesRepository(VehiclesRepositoryRef ref) {
  return VehiclesRepository(ref);
}

@riverpod
List<Vehicle> vehicles(VehiclesRef ref) {
  return [
    Vehicle(id: 1, name: 'Supra X 125', description: 'KPH is a very good sign', note: 'Noisy'),
    Vehicle(id: 2, name: 'Grand', description: 'GN5'),
    Vehicle(id: 3, name: 'Revo FI 2019')
  ];
}