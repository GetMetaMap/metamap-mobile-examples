   var exec = require("cordova/exec");

    exports.setMetaMapCallback = function(success, error) {
        exec(success, error, "MetaMapGlobalIDSDK", "setMetaMapCallback", []);
    }

    exports.showMetaMapFlow = function(params, success, error) {
      var { metadata } = params
      params = { ...params, metadata: {...metadata, sdkType: "cordova"}}
      exec(success, error, "MetaMapGlobalIDSDK", "showMetaMapFlow", [params]);
    }