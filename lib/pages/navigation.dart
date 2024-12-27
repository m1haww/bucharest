import 'package:bucharest/pages/alfa.dart';
import 'package:bucharest/pages/beta.dart';
import 'package:bucharest/pages/gama.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _currentIndex = 0;

  final List<Widget> _tabViews = [
    alfa(), // Asigură-te că numele claselor sunt corecte.
    const gama(),
    beta(),
  ];

  final List<IconData> _tabIcons = [
    CupertinoIcons.time,
    CupertinoIcons.map,
    CupertinoIcons.profile_circled,
  ];

  final List<String> _tabLabels = [
    "Alfa",
    "Gama",
    "Beta",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabViews[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: Color(0xffa3865d),
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: List.generate(
          _tabIcons.length,
          (index) => BottomNavigationBarItem(
            icon: Icon(_tabIcons[index]),
            label: _tabLabels[index],
          ),
        ),
      ),
    );
  }
}
