import 'package:flutter/material.dart';

class SettingPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Settings'),
      ),
      body: Column(
        children: <Widget>[
          new Container(
              height: 8.0,
          ),
          new Container(
            height: 100.0,
            width: MediaQuery.of(context).size.width,
            color: Colors.grey,
            child: new Row(
              children: <Widget>[
                new Container(
                  child: new Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.all(16.0),
                    child: Image.network('https://raw.githubusercontent.com/flutter/website/master/src/_includes/code/layout/lakes/images/lake.jpg')
                  )
                ),
                new Container(
                  padding: EdgeInsets.all(16.0),
                  child: new Text('Username', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, fontFamily: 'RobotoMono'),),
                )
              ],
            ),
          ),
          new Container(
              height: 16.0,
          ),
          GestureDetector(
            onTap: () {
              print('pressed');
            },
            child: new Container(
              height: 60.0,
              width: MediaQuery.of(context).size.width,
              color: Colors.grey,
              alignment: Alignment.center,
              padding: EdgeInsets.only(left: 16.0),
              child: Row(
                children: <Widget>[
                  Icon(Icons.toc),
                  new Container(
                    padding: EdgeInsets.only(left: 8.0),
                    child: new Text('My Posts', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),),
                  )
                ]
              )
            )
          )
        ],
      )
    );
  }  
}