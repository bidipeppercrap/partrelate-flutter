import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../repositories/parts_to_vehicle_parts.dart';

part 'parts_to_vehicle_parts.g.dart';

@riverpod
PartsToVehiclePartsRepository partsToVehiclePartsRepository(PartsToVehiclePartsRepositoryRef ref) {
  return PartsToVehiclePartsRepository(ref);
}