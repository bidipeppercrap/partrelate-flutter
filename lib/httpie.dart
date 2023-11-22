import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

import 'stores/settings.dart';

class Httpie {
  const Httpie(this.ref);
  final Ref ref;

  Future<Response> post(
      String route,
      Object data,
      {bool useAuth = true}) {
    final settingsRepository = ref.read(settingsRepositoryProvider);
    final uri = settingsRepository.getRouteUri(route);
    final body = jsonEncode(data);
    final authToken = settingsRepository.authToken();
    final headers = {
      'Authorization': 'Bearer $authToken'
    };

    return http.post(
      uri,
      headers: headers,
      body: body
    );
  }

  Future<Response> put(
      String route,
      Object data,
      {bool useAuth = true}) {
    final settingsRepository = ref.read(settingsRepositoryProvider);
    final uri = settingsRepository.getRouteUri(route);
    final body = jsonEncode(data);
    final authToken = settingsRepository.authToken();
    final headers = {
      'Authorization': 'Bearer $authToken'
    };

    return http.put(
        uri,
        headers: headers,
        body: body
    );
  }

  Future<Response> delete(
      String route,
      {bool useAuth = true}
      ) {
    final settingsRepository = ref.read(settingsRepositoryProvider);
    final uri = settingsRepository.getRouteUri(route);
    final authToken = settingsRepository.authToken();
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $authToken'
    };

    return http.delete(
        uri,
        headers: headers
    );
  }

  Future<Response> get(
      String route,
      {bool useAuth = true}
      ) {
    final settingsRepository = ref.read(settingsRepositoryProvider);
    final uri = settingsRepository.getRouteUri(route);
    final authToken = settingsRepository.authToken();
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $authToken'
    };

    return http.get(
      uri,
      headers: headers
    );
  }
}