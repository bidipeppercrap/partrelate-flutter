import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:partrelate/types/response.dart';

import '../types/vehicle.dart';
import '../types/vehicle_detail.dart';
import '../stores/httpie.dart';

class VehiclesRepository {
  const VehiclesRepository(this.ref);
  final Ref ref;

  Future<PaginatedResponse<Vehicle>> fetch([String? keyword = '', int? page = 1]) async {
    final httpie = ref.read(httpieProvider);
    final response = await httpie.get('/vehicles?keyword=$keyword&page=$page');

    if (response.statusCode == 200) {
      final PaginatedResponse<Vehicle> paginated = PaginatedResponse
          .fromJson(response.body, Vehicle.fromJsonList);

      return paginated;
    } else {
      throw Exception('Failed to load vehicles.');
    }
  }

  Future<VehicleDetail> get(int id) async {
    final httpie = ref.read(httpieProvider);
    final response = await httpie.get('/vehicles/$id');

    if (response.statusCode == 200) {
      final vehicle = VehicleDetail.fromJson(jsonDecode(response.body) as Map<String, dynamic>);

      return vehicle;
    } else {
      throw Exception('Failed to load vehicle.');
    }
  }

  Future<void> add(Vehicle vehicle) async {
    final httpie = ref.read(httpieProvider);
    final response = await httpie.post('/vehicles', {
      'name': vehicle.name,
      'description': vehicle.description,
      'note': vehicle.note
    });

    if (response.statusCode != 200) {
      throw Exception(response.body);
    }
  }

  Future<void> update(Vehicle vehicle, int id) async {
    final httpie = ref.read(httpieProvider);
    final response = await httpie.put('/vehicles/$id', {
      'name': vehicle.name,
      'description': vehicle.description,
      'note': vehicle.note
    });

    if (response.statusCode != 200) {
      throw Exception(response.body);
    }
  }

  Future<void> delete(int id) async {
    final httpie = ref.read(httpieProvider);
    final response = await httpie.delete('/vehicles/$id');

    if (response.statusCode == 200) {
    } else {
      throw Exception('Failed to delete vehicle.');
    }
  }
}