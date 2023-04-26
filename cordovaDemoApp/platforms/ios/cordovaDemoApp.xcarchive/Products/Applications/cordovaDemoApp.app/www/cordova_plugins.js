cordova.define('cordova/plugin_list', function(require, exports, module) {
  module.exports = [
    {
      "id": "metamap-cordova-plugin.MetaMapGlobalIDSDK",
      "file": "plugins/metamap-cordova-plugin/www/MetaMapGlobalIDSDK.js",
      "pluginId": "metamap-cordova-plugin",
      "clobbers": [
        "cordova.plugins.MetaMapGlobalIDSDK"
      ]
    },
    {
      "id": "metamap-cordova-plugin.MetaMapGlobalIDSDK",
      "file": "plugins/metamap-cordova-plugin/www/MetaMapGlobalIDSDK.js",
      "pluginId": "metamap-cordova-plugin",
      "clobbers": [
        "MetaMapGlobalIDSDK"
      ]
    }
  ];
  module.exports.metadata = {
    "metamap-cordova-plugin": "0.0.4"
  };
});