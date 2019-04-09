import '../models/student.dart';
import '../utils/database_helper.dart';
import './vertex.dart';
import '../models/event.dart';

class EventHandler{
    
    Vertex _vertex = new Vertex();

    String __getAccessToken(){

      final String token = null;

      //Used to get Access Token;
      //Get token form database;
      return token;
    }

    sendEvent2({sas,sas2}){

    }
  
    sendEvent({ event, sendWithToken, eventType, data}){
  
        // generate Event
      final token = this.__getAccessToken();
      OutgoingEvent eventObject;
      sendWithToken
      ? eventObject = event( eventType, data, token)
      : eventObject = event( eventType, data);

      print( 'sending event ::' + eventObject.toString() );
      /*Vertx.sendMessage( eventObject );*/
    }
}