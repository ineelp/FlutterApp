import './event_handler.dart';
import '../models/event.dart';

/*Event helper class any user event will first call method from this class*/
class EventHelper{

    EventHandler eventHandler = new EventHandler();

    sendCode(eventType,data){

      eventHandler.sendEvent(
        event: SendCode,
        sendWithToken: true,
        eventType:null,
        data:null);
    }
    
    sendBtnCode(){
      eventHandler.sendEvent(  
        event: sendCode,
        sendWithToken: true,
        eventType:null,
        data:null);
    }

    sendAnswers(answers){
      eventHandler.sendEvent(
      event: answerEvent,
      sendWithToken: true,
      eventType:null,
      data: answers);
    }

    sendAnswer(answers){
        sendAnswers([answers]);
    }

    sendButtonEvent(eventType, data){
        eventHandler.sendEvent(
          event: buttonClickEvent,
          sendWithToken: true,
          eventType : eventType,
          data: data
        );
    }

    sendTreeViewEvent(eventType, data){
        eventHandler.sendEvent(
          event : tvEvent,
          sendWithToken : true,
          eventType : eventType,
          data: data
        );
    }
}