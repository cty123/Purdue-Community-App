import 'package:flutter/material.dart';
import 'package:hello_world/screens/home.dart';
import 'package:hello_world/screens/login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      routes: <String, WidgetBuilder>{
        'Login': (BuildContext context) => new Login(),
        'Home': (BuildContext context) => new Home(),
      },
      home: new Home(),
    );
  }
}

// class LoginPage extends StatefulWidget {
//   LoginPage({Key key, this.title}) : super(key: key);

//   final String title;

//   @override
//   _LoginPageState createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[

//           ],
//         ),
//       ),
      
//       bottomNavigationBar: BottomNavigationBar(
//        currentIndex: 0, // this will be set when a new tab is tapped
//        items: [
//          BottomNavigationBarItem(
//            icon: new Icon(Icons.home),
//            title: new Text('Home'),
//          ),
//          BottomNavigationBarItem(
//            icon: new Icon(Icons.mail),
//            title: new Text('Messages'),
//          ),
//          BottomNavigationBarItem(
//            icon: Icon(Icons.person),
//            title: Text('Profile')
//          )
//        ],
//       ),
//     );
//   }
//}
