import 'package:flutter/material.dart';
import '../get_envs/login.dart';


class Home extends StatelessWidget { 

   final KeycloakSetting keycloakSetting;

   Home({Key key, @required this.keycloakSetting}): super(key:key);

   @override
    Widget build(BuildContext context) {
      return new Scaffold(
        appBar: AppBar(
          title: new Text('Weekly Journals')),
          body: new Container(
            child: new Column(
              children: <Widget>[
                Padding(padding: new EdgeInsets.all(20.5)),
                new Text("Token: ${keycloakSetting.token}",
                style: new TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.lightBlue[600],
                  fontSize: 22.5
                )),
              ],
            ),
          ),
        );
  }  
}
