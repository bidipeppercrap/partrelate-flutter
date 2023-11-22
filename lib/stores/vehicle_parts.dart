import '../repositories/vehicle_parts.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'vehicle_parts.g.dart';

@riverpod
VehiclePartsRepository vehiclePartsRepository(VehiclePartsRepositoryRef ref) {
  return VehiclePartsRepository(ref);
}