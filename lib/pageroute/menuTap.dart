import 'package:flutter/material.dart';
import 'package:projectbuddytravel/page/MapPage.dart';
import 'package:projectbuddytravel/page/ReportPage.dart';
import 'package:projectbuddytravel/page/noPage.dart';
import 'package:projectbuddytravel/page/settingPage.dart';
import 'package:projectbuddytravel/page/timelinePage.dart';

class MenuTap extends StatefulWidget {
  const MenuTap({Key? key}) : super(key: key);

  @override
  State<MenuTap> createState() => _MenuTapState();
}

class _MenuTapState extends State<MenuTap> {
  @override
  int _currentItem=0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'รายการสถานที่',
      style: optionStyle,
    ),
    Text(
      'แผนที่',
      style: optionStyle,
    ),
  ];
  final Tap=[
    ReportPage(),
    MapPage(),
    Timeline(),
    No(),
    Setting(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentItem = index;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Tap.elementAt(_currentItem),
      ),
      bottomNavigationBar: BottomNavigationBar(

        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: 'รายการสถานที่',
            backgroundColor: Colors.blueAccent,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'แผนที่',
            backgroundColor: Colors.blueAccent,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.timeline),
            label: 'ไทม์ไลน์',
            backgroundColor: Colors.blueAccent,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: '...',
            backgroundColor: Colors.blueAccent,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'ตั้งค่า',
            backgroundColor: Colors.blueAccent,
          ),
        ],
        currentIndex: _currentItem,
        selectedItemColor: Colors.black54,
        onTap: _onItemTapped,
      ),
    );
  }
}
