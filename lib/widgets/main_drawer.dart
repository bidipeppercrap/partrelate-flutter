import 'package:flutter/material.dart';

import '../screens/screen.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({
    super.key,
    required this.selectedIndex,
    required this.selectScreen,
    required this.screens
  });

  final int selectedIndex;
  final Function(int, String) selectScreen;
  final List<ScreenModel> screens;

  List<ListTile> _generateRoutes(BuildContext context) {
    List<ListTile> tiles = <ListTile>[];

    for (var screen in screens) {
      ListTile tile = ListTile(
        title: Text(screen.title),
        selected: selectedIndex == screens.indexOf(screen),
        onTap: () {
          selectScreen(screens.indexOf(screen), screen.title);
          Navigator.pop(context);
        }
      );

      tiles.add(tile);
    }

    return tiles;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const SizedBox(height: 50,),
          const Padding(
              padding: EdgeInsets.all(25),
              child: Text('PartRelate', style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold
              )
            )
          ),
          ..._generateRoutes(context)
        ]
      ),
    );
  }
}