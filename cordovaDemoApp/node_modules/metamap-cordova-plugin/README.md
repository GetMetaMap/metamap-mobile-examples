---
title: "Ionic Cordova"
excerpt: "MetaMap's Ionic Cordova SDK"
slug: "ionic-cordova-sdk"
category: 61ae8e8dba577a0010791480
---

| LTS version (Recommended for most users): | Current Version(Latest features) |
|-------------------------------------------|----------------------------------|
|1.4.10                                     | 1.4.10                           |

### Install MetaMap for Cordova

1. add target minimum version on the  config.xml file
```bash
<preference name="deployment-target" value="12.0" />
```

2. add the plugin:
```bash
npm i metamap-cordova-plugin@1.4.10
```

3. Add the MetaMap button to your HTML file:

**HTML Example for Cordova**
```bash
 <input
     class="metaMapButton"
     id="metaMapButton"
     type="button"
     value="show MetaMap Flow"
     />
 ```

<a id="cordova-javascript"></a>
#### JavaScript

4. Add the MetaMap button in your JavaScript file `index.js`:

**JavaScript Example for Cordova**

```bash
function onDeviceReady() {

//trigger login on button click
var metaMapButton = document.getElementById("metaMapButton");

  metaMapButton.onclick = () => {
      //set 3 params clientId (cant be null), flowId, metadata
      var yourMetadata = { param1: "value1", param2: "value2" }
      var metaMapButtinParams = { clientId: "YOUR_CLIENT_ID", flowId: "YOUR_FLOW_ID", metadata: yourMetadata }
      cordova.plugins.MetaMapGlobalIDSDK.showMetaMapFlow(metaMapButtinParams)
    };

    //register to callback
    cordova.plugins.MetaMapGlobalIDSDK.setMetaMapCallback(
     params => {
       console.log("setMetaMapCallback success: " + params.identityId);
       console.log("setMetaMapCallback success: " + params.verificationID);
     },
     error => {
       console.log("setMetaMapCallback error: " + error);
     }
    );

}
 ```

### Install MetaMap for Ionic Cordova


1. add target minimum version on the  config.xml file
```bash
<preference name="deployment-target" value="12.0" />
```

2. add the plugin:
```bash
ionic cordova plugin add metamap-cordova-plugin
```

3. Add the MetaMap button to your HTML file:

**HTML Example for Ionic Cordova**
```bash
 <input
     class="metaMapButton"
     id="metaMapButton"
     type="button"
     value="show MetaMap Flow"
     />
 ```


4. Add the MetaMap button in your JavaScript file `index.js`:

**JavaScript Example for Ionic Cordova**

```bash
function onDeviceReady() {

//trigger login on button click
var metaMapButton = document.getElementById("metaMapButton");

  metaMapButton.onclick = () => {
      //set 3 params clientId (cant be null), flowId, metadata
      var yourMetadata = { param1: "value1", param2: "value2" }
      var metaMapButtinParams = { clientId: "YOUR_CLIENT_ID", flowId: "YOUR_FLOW_ID", metadata: yourMetadata }
      cordova.plugins.MetaMapGlobalIDSDK.showMetaMapFlow(metaMapButtinParams)
    };

    //register to callback
    cordova.plugins.MetaMapGlobalIDSDK.setMetaMapCallback(
      params => {
       console.log("setMetaMapCallback success: " + params.identityId);
       console.log("setMetaMapCallback success: " + params.verificationID);
     },
     error => {
       console.log("setMetaMapCallback error: " + error);
     }
    );

}
 ```


## Android

Download the latest version of MetaMap for Android [here](https://search.maven.org/artifact/com.getmati/mati-sdk).

1. Check that your project's Gradle file (`<YourProject>/platforms/android/mati-global-id-sdk-cordova-plugin/<demoCordovaMati-build>.gradle`) uses the latest version of Mati for Cordova:

```bash
    dependencies {
      implementation 'com.getmati:mati-sdk:<LATEST_VERSION>'
    }
  ```

2. Enable AndroidX support in `config.xml`.

```bash
   <platform name="android">
   	<preference name="AndroidXEnabled" value="true" />
   </platform>
   ```

## iOS

1. In the `info.plist` file, add the following permissions to capture video, access the photo gallery, and capture audio for voiceliveness:
   **Info.plist**

```bash
    <key>NSCameraUsageDescription</key>
    <string>MetaMap needs access to your Camera</string>
    
    <key>NSPhotoLibraryUsageDescription</key>
    <string>MetaMap needs access to your media library</string>
    
    <key>NSMicrophoneUsageDescription</key>
    <string>MetaMap needs access to your Microphone</string>
    
    <key>NSLocationWhenInUseUsageDescription</key>
    <string>MetaMap will use your location information to provide best possible verification experience.</string>
	
    <key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
	<string>MetaMap will use your location information to provide best possible verification experience.</string>
	
	<key>NSLocationAlwaysUsageDescription</key>
    <string>MetaMap will use your location information to provide best possible verification experience.</string>
   ```

## Metadata Usage

Metadata is an additional optional parameters:

1. Set the Language:
```bash
yourMetadata: {"fixedLanguage": "es"}
   ```

2. Set the Button Color:
```bash
yourMetadata: {"buttonColor": "hexColor"}
   ```

3. Set the Title color of the button:
```bash
yourMetadata: {"buttonTextColor": "hexColor"}
 ```

4. Set identity Id as parameter for re-verification:
```bash
yourMetadata: {"identityId": "value"}
```

## Some error codes you may get during integration

`402` - MetaMap services are not paid: please contact your customer success manager

`403` - MetaMap credentials issues: please check your client id and MetaMap id