import '../models/bridgeenvs.dart';

Map testMap = {
  '_realm1': "sad",
    '_authServerUrl': "eee",
    '_sslExternal': "eee",
    '_credentialsSecret' : "sas",
    '_vertexUrl' : "sas",
    '_apiUrl' : "sas",
    '_url' : "sas",
    '_ENV_GENNY_HOST' : "sas",
    '_ENV_GENNY_INITURL': "sas",
};

main(){
      testMap.forEach((key,val) => {
             BridgeEnvs.map[key] =  testMap[key],
             print (BridgeEnvs.map[key])
          });
        print("Success");
}