cordova.define("mati-global-id-sdk-cordova-plugin.MatiGlobalIDSDK", function(require, exports, module) {
 var exec = require("cordova/exec");

    exports.coolMethod = function(arg0, success, error) {
      exec(success, error, "MatiGlobalIDSDK", "coolMethod", [arg0]);
    };

    exports.setParams = function(arg0, success, error) {
      exec(success, error, "MatiGlobalIDSDK", "setParams", [arg0]);
    };

    exports.showMatiFlow = function(success, error) {
      exec(success, error, "MatiGlobalIDSDK", "showMatiFlow", []);
    };
    
    exports.setMatiCallback = function(success, error) {
      exec(success, error, "MatiGlobalIDSDK", "setMatiCallback", []);
    };
});
