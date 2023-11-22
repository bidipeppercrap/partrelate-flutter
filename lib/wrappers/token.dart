import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../screens/login.dart';
import '../stores/settings.dart';

class TokenWrapper extends ConsumerWidget {
  const TokenWrapper({
    super.key,
    required this.finishRoute
  });

  final Widget finishRoute;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsRepository = ref.read(settingsRepositoryProvider);
    final authToken = settingsRepository.authToken();

    if (authToken.isEmpty) {
      return const LoginScreen();
    }

    return finishRoute;
  }
}