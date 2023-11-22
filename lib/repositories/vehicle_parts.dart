import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../stores/httpie.dart';
import '../types/vehicle_part.dart';

class VehiclePartsRepository {
  const VehiclePartsRepository(this.ref);
  final Ref ref;

  Future<void> add(VehiclePart vehiclePart) async {
    final httpie = ref.read(httpieProvider);
    final response = await httpie.post('/vehicle_parts', {
      'vehicleId': vehiclePart.vehicleId,
      'name': vehiclePart.name,
      'description': vehiclePart.description,
      'note': vehiclePart.note
    });

    if (response.statusCode != 200) {
      throw Exception(response.body);
    }
  }

  Future<VehiclePart> get(int id) async {
    final httpie = ref.read(httpieProvider);
    final response = await httpie.get('/vehicle_parts/$id');

    if (response.statusCode == 200) {
      final vehiclePart = VehiclePart.fromJson(jsonDecode(response.body) as Map<String, dynamic>);

      return vehiclePart;
    } else {
      throw Exception('Failed to load vehicle part.');
    }
  }

  Future<void> update(VehiclePart vehiclePart, int id) async {
    final httpie = ref.read(httpieProvider);
    final response = await httpie.put('/vehicle_parts/$id', {
      'vehicleId': vehiclePart.vehicleId,
      'name': vehiclePart.name,
      'description': vehiclePart.description,
      'note': vehiclePart.note
    });

    if (response.statusCode != 200) {
      throw Exception(response.body);
    }
  }

  Future<void> delete(int id) async {
    final httpie = ref.read(httpieProvider);
    final response = await httpie.delete('/vehicle_parts/$id');

    if (response.statusCode == 200) {
    } else {
      throw Exception('Failed to delete vehicle part.');
    }
  }
}