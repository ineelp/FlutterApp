import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import '../weeklyJournal/home.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import '../models/student.dart';
import '../models/bridgeenvs.dart';
import '../utils/database_helper.dart';



class Login extends StatefulWidget{
  @override
  State createState() => new KeycloakLogin();

}

class KeycloakLogin extends State<Login>{
 
    var _token; 
    var _flutterWebviewPlugin = new FlutterWebviewPlugin();
    var _url;
  
  //We need to call this function as it initates the State
    @override
    void initState()  {
      fetchEnvs();

      print(BridgeEnvs.ENV_GENNY_BRIDGE_VERTEX);
      print("Running Keycloack Login"); 

      getToken();

    }

    @override
    Widget build(BuildContext context) {

        if(_url != null){
          return MaterialApp(
            routes: {
              "/":(_) => new WebviewScaffold(
                url: _url,
              ),
            }
          );
        }
        else{
          return Scaffold(
            appBar: AppBar(
            title: new Text('Login Into KeyClock'),
            ));
            }
        }

    void navigateHome(){
      dispose();

      print("Navigating to App Home.");
      Navigator.push(context, new MaterialPageRoute(builder: (context) => new Home(token: _token)));
    }

    /*disposes webviewplugin and webview scaffold*/
    void dispose(){

      _flutterWebviewPlugin.close();
      _flutterWebviewPlugin.dispose();
      super.dispose();
      print("Webview Resources Disposed...");
    }

    void getToken(){

        setState(() {
          _url = BridgeEnvs.ENV_GENNY_INITURL;
        });

        /* listening to eny url change in the browser */
        _flutterWebviewPlugin.onUrlChanged.listen((String url){
            print("Redirecting to "+ _url);
            RegExp regExp = new RegExp("code=(.*)");
            String token = regExp.firstMatch(url)?.group(1);

            if(token != null){

              print("Found Token: " + token);
              _token = token ;
              //storeInDB(keycloakSetting._token);
              navigateHome();
            }
          });
    }

    /*fetching envs */
    void fetchEnvs(){

      var initurl = "https://internmatch.outcome-hub.com";
      var url = initurl+"/api/events/init?url="+initurl;
      getEnvFromBridge(url);
    }

    /*Saving it to the database */
    void storeInDB(String token) async {

      var db = new DatabaseHelper();  
      var saveToken = await db.saveToken(new Student("$token"));
      print("Token entered  $saveToken into Student Table.");
    } 

    void fetchTokenFromDB() async{
      var db = new DatabaseHelper();  
      Student tokenDB = await db.fetchTokenFromDb(1);
      print("Token from DB: ${tokenDB.token}");
    }

  /*getting bridge envs*/
    getEnvFromBridge(apiUrl){

        print("Fetching Envs From ::::" + apiUrl);
        
        /* getting json object from */
        makeApiRequest(apiUrl).then((data){
            print("made already");

            /* Looping through and saving the necessary envs value */
            BridgeEnvs.map.forEach((key,val) => {
              print(key),
              BridgeEnvs.map[key] =  data[key],
          });
      });
    }
    
  /*getting settings url */
    Future<Map> makeApiRequest(final url) async{
        http.Response response= await http.get(url);
        print(response.body);
        return json.decode(response.body);
    }
}



