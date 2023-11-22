import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../stores/settings.dart';
import '../main.dart';
import '../types/credential.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final serverController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> _submit() async {
    final settingsRepository = ref.read(settingsRepositoryProvider);

    await settingsRepository.setServerUrl(serverController.text);

    final credentials = Credential(
      username: usernameController.text,
      password: passwordController.text
    );

    try {
      final response = await http.post(
          settingsRepository.getRouteUri('/login'),
          body: jsonEncode({
            'username': credentials.username,
            'password': credentials.password
          })
      );

      if (response.statusCode == 200) {
        await settingsRepository.setAuthToken(response.body);

        if (!mounted) return;
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MyHomePage()),
        );
      } else {
        final snackBar = SnackBar(content: Text('Failed to login: ${response.body}'));

        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        return;
      }
    } catch (e) {
      final snackBar = SnackBar(content: Text(e.toString()));

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }

  }

  @override
  void initState() {
    super.initState();

    final settingsRepository = ref.read(settingsRepositoryProvider);

    serverController.text = settingsRepository.serverUrl();
  }

  @override
  void dispose() {
    serverController.dispose();
    usernameController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: serverController,
              decoration: const InputDecoration(
                  labelText: 'Server'
              ),
            ),
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(
                labelText: 'Username'
              ),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
            ),
            const SizedBox(height: 16,),
            ElevatedButton(onPressed: _submit, child: const Text('Submit'))
          ]
        )
      ),
    );
  }
}