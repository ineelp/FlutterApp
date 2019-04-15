import '../models/event.dart';
import './websocket.dart';
import 'dart:convert';

EventHandler eventHandler = new EventHandler();

/* will be removed soon */
class Settings{

  static final vertexUrl = "wss://bridge-internmatch.outcome-hub.com/frontend/asdas/asdasd/websocket";
  }

class EventHandler{

    static final EventHandler _eventHandler = new EventHandler._internal();

    factory EventHandler(){
      return _eventHandler;
    }

    EventHandler._internal(){

        /* Initialize connection with vertex */
        socket.initCommunication(Settings.vertexUrl);

//        socket.addListener(handleIncomingMessage);
    }

    String __getAccessToken(){

      final String token = null;

      //Get token form database;
      return token;
    }

    sendEvent({ event, sendWithToken, eventType, data}){
  
        // generate Event
      final token = this.__getAccessToken();
      OutgoingEvent eventObject;

      sendWithToken ? eventObject = event( eventType, data, token)
      : eventObject = event( eventType, data);

      print( 'sending event ::' + eventObject.toString() );
      socket.sendMessage( eventObject );
    }

    handleIncomingMessage(incomingMessage){

      Map message = json.decode(incomingMessage);
      //Neeed more to do 
      print (message);

    }

    main(){
        socket.initCommunication(Settings.vertexUrl);

    }

}