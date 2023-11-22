import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../types/part_to_vehicle_part.dart';
import '../stores/httpie.dart';

class PartsToVehiclePartsRepository {
  const PartsToVehiclePartsRepository(this.ref);
  final Ref ref;

  Future<void> add(PartToVehiclePart data) async {
    final httpie = ref.read(httpieProvider);
    final response = await httpie.post('/parts_to_vehicle_parts', {
      'partId': data.partId,
      'vehiclePartId': data.vehiclePartId,
      'description': data.description,
      'quantity': data.quantity
    });

    if (response.statusCode != 200) {
      throw Exception(response.body);
    }
  }

  Future<void> update(PartToVehiclePart data, int id) async {
    final httpie = ref.read(httpieProvider);
    final response = await httpie.put('/parts_to_vehicle_parts/$id', {
      'partId': data.partId,
      'vehiclePartId': data.vehiclePartId,
      'description': data.description,
      'quantity': data.quantity
    });

    if (response.statusCode != 200) {
      throw Exception(response.body);
    }
  }

  Future<void> delete(int id) async {
    final httpie = ref.read(httpieProvider);
    final response = await httpie.delete('/parts_to_vehicle_parts/$id');

    if (response.statusCode == 200) {
    } else {
      throw Exception('Failed to delete data.');
    }
  }
}