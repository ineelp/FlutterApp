import 'package:flutter/material.dart';
import '../utils/event_helper.dart';
import '../utils/event_handler.dart';
class Home extends StatelessWidget { 

   var token ;
   final eventHelper = new EventHelper();

    initState(){
      eventHandler.initWebSocketConnection();
    }
    
   Home({Key key, @required this.token}): super(key:key);

   @override
    Widget build(BuildContext context) {
      return new Scaffold(
        appBar: AppBar(
          title: new Text('Weekly Journals')),
          body: new Container(
            child: new Column(
              children: <Widget>[
                Padding(padding: new EdgeInsets.all(20.5)),
                new Text("Token: $token",
                style: new TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.lightBlue[600],
                  fontSize: 22.5
                )),
                new Padding(padding: const EdgeInsets.all(12.8),),
                new FlatButton(
                  onPressed: (){
                      eventHelper.sendButtonEvent( 'BTN_CLK_EVENT',{'value':{'itemCode' : 'Dummy_code'}});
                      print("Trying to connect with Backend!");
                  },
                  child: Text("Connect with Backend!"),
                )
              ],
            ),
          ),
        );
  }  
}
