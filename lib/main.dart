import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:partrelate/wrappers/token.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screens/login.dart';
import 'screens/parts.dart';
import 'screens/screen.dart';
import 'screens/vehicles.dart';
import 'stores/prefs.dart';
import 'widgets/main_drawer.dart';

Future<void> main() async {
// ignore: missing_provider_scope
  runApp(const LoadingScreen());

  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();

  runApp(
      ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(prefs)
        ],
        child: const MyApp()
      )
  );
}

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PartRelate',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: Container(
        color: Colors.white,
        child: const Center(
          child: CircularProgressIndicator(
            color: Colors.black,
          ),
        )
      )
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PartRelate',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: const TokenWrapper(finishRoute: MyHomePage())
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  static final List<ScreenModel> _screenOptions = <ScreenModel>[
    const ScreenModel(title: 'Vehicles', screen: VehiclesScreen()),
    const ScreenModel(title: 'Parts', screen: PartsScreen())
  ];

  void _setScreenIndex(int index, String title) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(_screenOptions[_selectedIndex].title),
      ),
      body: Center(
        child: _screenOptions[_selectedIndex].screen,
      ),
      drawer: MainDrawer(
        selectedIndex: _selectedIndex,
        selectScreen: _setScreenIndex,
        screens: _screenOptions,
      ),
      floatingActionButton: null, // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
