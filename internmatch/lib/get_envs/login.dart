import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import '../weeklyJournal/home.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import '../models/student.dart';
import '../utils/database_helper.dart';


class Login extends StatefulWidget{
  @override
  State createState() => new KeycloakLogin();
}

class KeycloakSetting {
  var _token;

  String get token{
    return _token;
  }

  var _url;
  String get url{
    return _url;
  }

  var _bridgeSettings;
  Map get bridgeSettings{
    return _bridgeSettings;
  }
  var _realmParam;
  Map get realmParam{
    return _realmParam;
  }
}

class KeycloakLogin extends State<Login>{

// pass token variable in constructor 
int saveToken;
  var _flutterWebviewPlugin = new FlutterWebviewPlugin();
  KeycloakSetting keycloakSetting = new KeycloakSetting();

//We need to call this function as it initates the State
  @override
  void initState()  {

    /*fetchEnvs();*/
    print("Running Keycloack Login");        
    getToken();
  }

  void navigateHome(){

    dispose();
    print("Navigating to App Home.");
    Navigator.push(context, new MaterialPageRoute(builder: (context) => new Home(keycloakSetting: this.keycloakSetting)));
  }

  void getToken(){

      setState(() {
        keycloakSetting._url = "https://internmatch.outcome-hub.com/";
      });

      /* listening to eny url change in the browser */
      _flutterWebviewPlugin.onUrlChanged.listen((String url){
          print("Reloading page and directing to "+ keycloakSetting._url);
          RegExp regExp = new RegExp("code=(.*)");
          String token = regExp.firstMatch(url)?.group(1);

          if(token != null){

            print("Found Token: saving .....");
            print("token: "+ token);
            keycloakSetting._token = token ;

            setState(() {
                storeInDB(keycloakSetting._token);
                navigateHome();
            });
          }
        });
  }


    void storeInDB(String token) async {

      var db = new DatabaseHelper();  
      saveToken = await db.saveToken(new Student("$token"));
      print("Token entered  $saveToken into Student Table.");
    } 

      void fetchTokenFromDB() async{
        var db = new DatabaseHelper();  
        Student tokenDB = await db.fetchTokenFromDb(1);
        print("Token from DB: ${tokenDB.token}");
    }

/* runthis method to fetch all the envs. Will be used at some point in future */
  void fetchEnvs(){

     getBridgeSettings().then((result){
        setState(() {
          keycloakSetting._bridgeSettings = result;

          getRealmParam().then((result){

            setState(() {
            keycloakSetting._realmParam = result;
            keycloakSetting._url =keycloakSetting._realmParam['account-service']; 
            });
          });
        });
    });
  }

  /*disposes webviewplugin and webview scaffold*/
  void dispose(){

    _flutterWebviewPlugin.close();
    _flutterWebviewPlugin.dispose();
    super.dispose();
    print("Webview Resources Disposed...");
  }


 @override
  Widget build(BuildContext context) {

      if(keycloakSetting._url != null){

        return MaterialApp(
          routes: {
            "/":(_) => new WebviewScaffold(
              url: keycloakSetting._url,
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
  

/*getting bridge envs*/
  Future<Map> getBridgeSettings() async{

      String apiUrl = "https://internmatch.outcome-hub.com/api/events/init?url=https://internmatch.outcome-hub.com";
      http.Response response= await http.get(apiUrl);
      print("Fetching Envs From Bridge::::");
      return json.decode(response.body);
     }

/*getting keycloack realm and token service url*/
   Future<Map> getRealmParam() async{

       String url= "${keycloakSetting._bridgeSettings["auth-server-url"]}/realms/${keycloakSetting._bridgeSettings["realm"]}"; 
       http.Response response= await http.get(url);
       print("Fetching Envs From " + url + "::::");
       return json.decode(response.body);
   }
}



