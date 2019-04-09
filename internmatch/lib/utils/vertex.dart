import '../models/student.dart';
import '../utils/database_helper.dart';

class Vertex{

    final RECONNECT_TIMEOUT = 1500;
    
    final State = {
      'connected' : false,
      'url' : null,
      'token' : null,
      'eventBus' : null,
      'reconnectedTimeout' : null,
      'messageQueue' : []
    };

    setStateValue(key, value){
      this.State[key] = value;
    }

    init(token){

      this.setStateValue('token',token);
    }
    
    openEventBus(url){
      /*final eventBus = new EventBus( url );
      this.State['EventBus'] = eventBus;
       this.State['EventBus'].onopen = this.handleEventBusOpen;
       this.State['EventBus'].onclose = this.handleEventBusClose;*/
    
    }

    handleEventBusOpen (){

    }

    pushToMessageQueue(message){

       /* this.State['messageQueue'].Add(message);*/
    }

    sendMessage( message ) {
      
      if (!this.State['connected']){

        this.pushToMessageQueue(message);
      }
      else {

        /*eventBus.send('address.inbound', { 'data' : message });*/
      }
      
    }    

}

