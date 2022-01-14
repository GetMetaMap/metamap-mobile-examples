   var exec = require("cordova/exec");

    exports.setMatiCallback = function(success, error) {
        exec(success, error, "MatiGlobalIDSDK", "setMatiCallback", []);
    }

    exports.showMatiFlow = function(params, success, error) {
      var { metadata } = params
      params = { ...params, metadata: {...metadata, sdkType: "cordova"}}
      exec(success, error, "MatiGlobalIDSDK", "showMatiFlow", [params]);
    }