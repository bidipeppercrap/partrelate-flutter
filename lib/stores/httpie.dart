import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../httpie.dart';

part 'httpie.g.dart';

@riverpod
Httpie httpie(HttpieRef ref) {
  return Httpie(ref);
}
