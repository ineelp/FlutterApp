import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class Login extends StatelessWidget {
/* String realm="";
String auth_server_url="";
String credentials="";
String vertx_url="";
String api_url=""; */

  Map _data;
  final TextEditingController _userController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();
  String _welcomeString = "";

  void _showWelcome() async {
    _data = await getBridge();

    print(_data);
  }

void _opennewpage(BuildContext context) {
    Navigator.of(context).pushNamed('/widget');
  }

  

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Internmatch"),
          centerTitle: true,
          backgroundColor: Colors.blueGrey[900],
        ),
        backgroundColor: Colors.blueGrey[400],
        body: new Container(
          alignment: Alignment.topCenter,
          child: new ListView(
            children: <Widget>[
              new Padding(padding: const EdgeInsets.all(50.6)),
              //form
              new Container(
                height: 280.0,
                width: 350.0,
                color: Colors.white,
                child: new Column(
                  children: <Widget>[
                    new Image.asset('images/logo.png', width: 250, height: 120),
                    new TextField(
                        controller: _userController,
                        decoration: new InputDecoration(
                          hintText: 'Username',
                          icon: new Icon(Icons.person),
                        )),
                    new TextField(
                      controller: _passwordController,
                      decoration: new InputDecoration(
                        hintText: 'Password',
                        icon: new Icon(Icons.lock),
                      ),
                      obscureText: true,
                    ),

                    //add padding
                    new Padding(padding: new EdgeInsets.all(10.5)),
                    new Center(
                      child: new Row(
                        children: <Widget>[
                          //Login Button
                          new Container(
                            margin: const EdgeInsets.only(left: 150.0),
                            child: new RaisedButton(
//                                onPressed: _showWelcome,
                                onPressed: () {
                                  _opennewpage();
                                },
                                color: Colors.blueGrey[700],
                                child: new Text("Login",
                                    style: new TextStyle(
                                        color: Colors.white, fontSize: 18))),
                          ),

                          new Container(),
                        ],
                      ),
                    ),
                  ],
                ),
              ), //forms ends here
              new Padding(padding: const EdgeInsets.all(10.5)),
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Text(
                    "Welcome, $_welcomeString",
                    style: new TextStyle(
                        color: Colors.white,
                        fontSize: 19.4,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              )
            ],
          ),
        ));
  }

  Future<Map> getBridge() async {
    String apiUrl =
        "https://internmatch.outcome-hub.com/api/events/init?url=https://internmatch.outcome-hub.com";

    http.Response response = await http.get(apiUrl);

    return json.decode(response.body);
  }
}