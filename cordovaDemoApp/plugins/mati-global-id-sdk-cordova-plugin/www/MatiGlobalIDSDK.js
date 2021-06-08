   var exec = require("cordova/exec");

    exports.coolMethod = function(arg0, success, error) {
      exec(success, error, "MatiGlobalIDSDK", "coolMethod", [arg0]);
    };

    exports.setParams = function(arg0, success, error) {
      exec(success, error, "MatiGlobalIDSDK", "setParams", [arg0]);
    };

    exports.showMatiFlow = function(arg0, success, error) {
      exec(success, error, "MatiGlobalIDSDK", "showMatiFlow", [arg0]);
    };
    
    exports.setMatiCallback = function(success, error) {
      exec(success, error, "MatiGlobalIDSDK", "setMatiCallback", []);
    };