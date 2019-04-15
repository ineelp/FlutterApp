 class BridgeEnvs{
    static var realm ;
    static var authServerUrl;
    static var sslExternal;
    static var credentialsSecret;
    static var vertexUrl;
    static var apiUrl;
    static var url;
    static var ENV_GENNY_HOST;
    static var ENV_GENNY_INITURL;
    static var ENV_GENNY_BRIDGE_SERVICE;
    static var ENV_GENNY_BRIDGE_EVENTS;
    static var ENV_GENNY_BRIDGE_VERTEX;
    static var ENV_SIGNATURE_URL;

    static final Map map= {
    '_realm': realm,
    '_authServerUrl': authServerUrl,
    '_sslExternal' : sslExternal,
    '_credentialsSecret' : credentialsSecret,
    '_vertexUrl' : vertexUrl,
    '_apiUrl' : apiUrl,
    '_url' : url,
    '_ENV_GENNY_HOST' : ENV_GENNY_HOST,
    '_ENV_GENNY_INITURL': ENV_GENNY_INITURL,
    '_ENV_GENNY_BRIDGE_SERVICE' : ENV_GENNY_BRIDGE_SERVICE,
    'ENV_GENNY_BRIDGE_EVENTS': ENV_GENNY_BRIDGE_EVENTS,
    'ENV_GENNY_BRIDGE_VERTEX': ENV_GENNY_BRIDGE_VERTEX,
    'ENV_SIGNATURE_URL': ENV_SIGNATURE_URL
    };
  
}



