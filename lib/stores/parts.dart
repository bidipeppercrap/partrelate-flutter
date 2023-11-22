import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../repositories/parts.dart';
import '../types/part.dart';

part 'parts.g.dart';

@riverpod
PartsRepository partsRepository(PartsRepositoryRef ref) {
  return PartsRepository(ref);
}

@riverpod
List<Part> parts(PartsRef ref) {
  return [
    Part(name: 'Seal Shock GN5 26 x 37 x 10.5', description: 'Can be used on most underbone and matic motorcycles'),
    Part(name: 'Camshaft GN5', note: 'Not suitable for Supra Fit New!')
  ];
}