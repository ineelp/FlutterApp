import 'dart:core';
import 'package:flutter/foundation.dart';
import '../models/event.dart';
import 'package:web_socket_channel/io.dart';
import 'dart:convert';

/*main(){

  //var vertexUrl = "wss://bridge-internmatch.outcome-hub.com/frontend/websocket";
  var vertexUrl = "https://bridge-internmatch.outcome-hub.com/frontend/websocket";
  socket.initCommunication(vertexUrl);
}*/

WebSockets socket = new WebSockets();

class WebSockets {
  static final WebSockets _sockets = new WebSockets._internal();

  factory WebSockets(){
    return _sockets;
  }

  WebSockets._internal();
  
  /*websocket ope channel */
  IOWebSocketChannel _channel;

  bool _isOn = false;

  /*CLoses the webSocket Communication*/
  reset(){
    if(_channel != null){
      if(_channel.sink != null){
        _channel.sink.close();
        _isOn = false;
      }
    }
  }

  /* Listener */
  /* List of methods to be called when a new message*/
  /* comes in. */

 ObserverList<Function> _listener = new ObserverList<Function>();

  /* Initializint the web socket connection */

  initCommunication(vertexUrl) async {
  try {
        print("WebSocket:: Trying to connect to "+ vertexUrl);
        
        _channel = await IOWebSocketChannel.connect(vertexUrl,headers: {'CONNECTION':'upgrade','UPGRADE':'websocket'});
        var message= AuthInit("as");
        sendMessage(json.encode(message.message()));
        _channel.stream.listen(_onIncomingMessage);

      } catch(e){
          print("WebSocket: Unable to make a connection with :" + vertexUrl);
          print("Exception logs: "+e.toString());
      } 
  }

  /* Send message to the vertex*/
  sendMessage(message){
    if(_channel != null){      
      if(_channel.sink != null){
        print("Sending Messsage::" + message);
        _channel.sink.add(json.encode(message));
      }
    }
  }
  
/*
/*Listenes for incomming message from server */
  addListener(Function callback){
    _listener.add(callback);
  }


/*Remove for message from server */
  removeListener(Function callback){
    _listener.remove(callback);
  }
*/

/*invoked each time when receiving the incoming message form the server*/
  _onIncomingMessage(message){
    _isOn = true;
    print("Receiving form the server");
    print(message);
    _listener.forEach((Function callback){
      callback(message);
      });
    }       
}
