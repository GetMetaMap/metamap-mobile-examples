cordova.define('cordova/plugin_list', function(require, exports, module) {
  module.exports = [
    {
      "id": "mati-global-id-sdk-cordova-plugin.MatiGlobalIDSDK",
      "file": "plugins/mati-global-id-sdk-cordova-plugin/www/MatiGlobalIDSDK.js",
      "pluginId": "mati-global-id-sdk-cordova-plugin",
      "clobbers": [
        "cordova.plugins.MatiGlobalIDSDK"
      ]
    }
  ];
  module.exports.metadata = {
    "cordova-plugin-whitelist": "1.3.4",
    "mati-global-id-sdk-cordova-plugin": "0.0.4"
  };
});