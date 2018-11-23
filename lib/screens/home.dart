import 'package:flutter/material.dart';
import 'package:hello_world/screens/homepage.dart';
import 'package:hello_world/screens/postview.dart';
import 'package:hello_world/screens/settingpage.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

 @override
 _Home createState() => new _Home();
}

class _Home extends State<Home> {
  int _selectedIndex = 1;

  final _widgetOptions = [
    new HomePage(),
    new PostListPage(),
    new SettingPage()
  ];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Center(
       child: _widgetOptions.elementAt(_selectedIndex),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex, 
        fixedColor: Colors.brown,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            title: new Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.mail),
            title: new Text('Messages'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('Profile')
          )
        ],
      ),
    );
  }

  void _onItemTapped(int index) {
   setState(() {
     _selectedIndex = index;
   });
  }
}