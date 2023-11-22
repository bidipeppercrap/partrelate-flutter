import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../stores/httpie.dart';
import '../types/response.dart';
import '../types/part.dart';

class PartsRepository {
  const PartsRepository(this.ref);
  final Ref ref;

  Future<PaginatedResponse<Part>> fetch([String? keywords = '', int? page = 1]) async {
    keywords ??= '';

    final httpie = ref.read(httpieProvider);
    final response = await httpie.get('/parts?keyword=$keywords&page=$page');

    if (response.statusCode == 200) {
      final PaginatedResponse<Part> paginated = PaginatedResponse
        .fromJson(response.body, Part.fromJsonList);

      return paginated;
    } else {
      throw Exception('Failed to load parts.');
    }
  }

  Future<Part> get(int id) async {
    final httpie = ref.read(httpieProvider);
    final response = await httpie.get('/parts/$id');

    if (response.statusCode == 200) {
      final part = Part.fromJson(jsonDecode(response.body) as Map<String, dynamic>);

      return part;
    } else {
      throw Exception('Failed to load part.');
    }
  }

  Future<void> delete(int id) async {
    final httpie = ref.read(httpieProvider);
    final response = await httpie.delete('/parts/$id');

    if (response.statusCode == 200) {
    } else {
      throw Exception('Failed to delete part.');
    }
  }

  Future<void> add(Part part) async {
    final httpie = ref.read(httpieProvider);
    final response = await httpie.post('/parts', {
      'name': part.name,
      'description': part.description,
      'note': part.note
    });

    if (response.statusCode != 200) {
      throw Exception(response.body);
    }
  }

  Future<void> update(Part part, int id) async {
    final httpie = ref.read(httpieProvider);
    final response = await httpie.put('/parts/$id', {
      'name': part.name,
      'description': part.description,
      'note': part.note
    });

    if (response.statusCode != 200) {
      throw Exception(response.body);
    }
  }
}