import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/io.dart';
import 'dart:convert';

WebSocketsNotification socket = new WebSocketsNotification();

class WebSocketsNotification {
  static final WebSocketsNotification _sockets = new WebSocketsNotification._internal();

  factory WebSocketsNotification(){
    return _sockets;
  }

  WebSocketsNotification._internal();
  
  
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

  initCommunication(vertexUrl) async{
  try {
        print("WebSocket:: Trying to connect to "+ vertexUrl);
        _channel = new IOWebSocketChannel.connect(
                    vertexUrl,
                    headers: {
                      'X-DEVICE-ID': 'safalsMcc',
                      'X-TOKEN': 'sadasdasdasdasdasd',
                      'X-APP-ID': 'internmatchApp',
                    });
      } catch(e){
          print("WebSocket: Unable to make a connection with :" + vertexUrl);
          print("Exception logs: "+e);
      }
    
  }

  /* Send message to the vertex*/
  sendMessage(message){
    print("Send MEssage 1");
    if(_channel != null){
      print("Send MEssage 2");
      if(_channel.sink != null && _isOn){
        print("Send MEssage 2");
        _channel.sink.add(json.encode(message));
      }
    }
  }

/*Listenes for incomming message from server */
  addListener(Function callback){
    _listener.add(callback);
  }

/*Remove for message from server */
  removeListener(Function callback){
    _listener.remove(callback);
  }

/*invoked each time when receiving the incoming message form the server*/
  _onIncomingMessageFromServer(message){
    _isOn = true;
    print("Receiving form the server");
    _listener.forEach((Function callback){
      callback(message);
      });
    }
}
