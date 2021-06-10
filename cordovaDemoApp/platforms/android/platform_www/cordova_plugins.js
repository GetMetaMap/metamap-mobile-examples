cordova.define('cordova/plugin_list', function(require, exports, module) {
module.exports = [
    {
        "file": "plugins/mati-global-id-sdk-cordova-plugin/www/MatiGlobalIDSDK.js",
        "id": "mati-global-id-sdk-cordova-plugin.MatiGlobalIDSDK",
        "clobbers": [
            "cordova.plugins.MatiGlobalIDSDK"
        ]
    }
];
module.exports.metadata = 
// TOP OF METADATA
{
    "cordova-plugin-cocoapod-support": "1.6.2",
    "cordova-plugin-whitelist": "1.3.4",
    "mati-global-id-sdk-cordova-plugin": "0.0.4"
};
// BOTTOM OF METADATA
});