import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../repositories/settings.dart';

part 'settings.g.dart';

@riverpod
SettingsRepository settingsRepository(SettingsRepositoryRef ref) {
  return SettingsRepository(ref);
}
