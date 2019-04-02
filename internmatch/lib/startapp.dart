import 'package:flutter/material.dart';
import './get_envs/login.dart';


class StartApp extends StatefulWidget {
  final Widget child; 

  StartApp({Key key, this.child}) : super(key: key);

  _StartAppState createState() => _StartAppState();
}

class _StartAppState extends State<StartApp> {

  @override
  void initState(){
    super.initState();

     new Future.delayed(
        const Duration(seconds: 10),
        () => Navigator.push(context, 
        MaterialPageRoute(builder: (context) => Login()),
        ));
  } 

  @override
  Widget build(BuildContext context) {
    
    return new Scaffold(

      body: new Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.all(30.0),
        child: new Column(
          children: <Widget>[
            new Image.asset('images/internmatch_logo.png',
            width: 100,
            repeat: ImageRepeat.noRepeat,
            height: 100),
            
            new Text("Please Wait",
                style: new TextStyle(
                fontSize: 19.5,
                color: Colors.blueGrey[800],
                fontWeight: FontWeight.w700 
                )),

              new Text("Loading...",
                style: new TextStyle(
                fontSize: 19.5,
                color: Colors.blueGrey[800],
                fontWeight: FontWeight.w700 
                )),
            
          ],),
      ),
        
      );
    }

  }