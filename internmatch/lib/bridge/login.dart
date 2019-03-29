import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';


class Login extends StatefulWidget{
  @override
  State createState() => new GetKeycloakSetting();

}

class GetKeycloakSetting extends State<Login>{
  var _url;
  var _bridgeSettings;
  var _realmParam;

//We need to call this function as it initates the State
  @override
  void initState()  {
    getBridgeSettings().then((result){
        setState(() {
          _bridgeSettings = result;

          getRealmParam().then((result){
          setState(() {
          _realmParam = result;
          _url =_realmParam['account-service'];
          print(_bridgeSettings);
         });
          });
        });
    });
      
  }

 @override
  Widget build(BuildContext context) {
  if (_url == null) {
            // This is what we show while we're loading
            return new Scaffold(
              appBar: new AppBar(
                title : new Text("Loading...."), 
              )
            );
        }
          else{
              return MaterialApp(
                routes: {
                  "/":(_) => new WebviewScaffold(
                    url: _url,
                  ),
                }
              );
    }
  }


  Future<Map> getBridgeSettings() async{
      String apiUrl = "https://internmatch.outcome-hub.com/api/events/init?url=https://internmatch.outcome-hub.com";
      http.Response response= await http.get(apiUrl);
      return json.decode(response.body);
     }

   Future<Map> getRealmParam() async{
       String url= "${_bridgeSettings["auth-server-url"]}/realms/${_bridgeSettings["realm"]}";
       print(url);
       http.Response response= await http.get(url);
       return json.decode(response.body);
   }
}



