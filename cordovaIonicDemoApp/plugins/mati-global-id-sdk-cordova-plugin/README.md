# Cordova&Ionic plugin for Mati SDK
## Recommended version of Cordova is 10. (minimum is 6.X+).
Create a new Cordova project or Ionic project
Add the SDK plugin with the following command

INSTALL: cordova plugin add https://github.com/GetMati/mati-cordova-plugin.git

UNINSTALL: cordova plugin remove mati-global-id-sdk-cordova-plugin

# Cordova.


### Create html

In your project add a button to trigger the login process.

### example of html for cordova
```
 <input
     class="matiButton"
     id="matiButton"
     type="button"
     value="show Mati Flow"
     />
 ```
 
### example of index.js for cordova

 ```    
function onDeviceReady() {
 
//trigger login on button click
var matiButton = document.getElementById("matiButton");

  matiButton.onclick = () => {
      //set 3 params clientId (cant be null), flowId, metadata
      var yourMetadata = { param1: "value1", param2: "value2" }
      var matiButtinParams = { clientId: "YOUR_FLOW_ID", flowId: "", metadata: yourMetadata }
      cordova.plugins.MatiGlobalIDSDK.showMatiFlow(matiButtinParams)
    };

    //register to callback
    cordova.plugins.MatiGlobalIDSDK.setMatiCallback(
     identityId => {
       console.log("setMatiCallback success: " + identityId);
     },
     error => {
       console.log("setMatiCallback error: " + error);
     }
    );

}
 ```
 
## Please see cordovaDemoApp folder for example on Cordova
https://github.com/GetMati/mati-mobile-examples/tree/main/cordovaDemoApp

# Ionic.

### example of html for Ionic
```
 <input
    class="matiButton"
    id="matiButton"
    type="button"
    value="show Mati Flow"
    ion-item (click)="showMatiFlow()"/>
 ```
 
### example of home.page.ts for Ionic

 ```    
import { Component } from '@angular/core';

//global instance of cordova
declare var cordova: any;

@Component({
  selector: 'app-home',
  templateUrl: 'home.page.html',
  styleUrls: ['home.page.scss'],
})
export class HomePage {

  constructor() {}
  
  ionViewDidEnter() {
    //register to callback
    cordova.plugins.MatiGlobalIDSDK.setMatiCallback(
      identityId => {
        console.log("setMatiCallback success: " + identityId);
      },
      error => {
        console.log("setMatiCallback error: " + error);
      }
    );  
  }

  showMatiFlow() {
   //set 3 params clientId (cant be null), flowId, metadata 
   var yourMetadata = { param1: "value1", param2: "value2" }
    var matiParams = { clientId: "YOUR_CLIENT_ID", flowId: "YOUR_FLOW_ID", metadata: yourMetadata }
    cordova.plugins.MatiGlobalIDSDK.showMatiFlow(matiParams);
  }

}
 ```
 
## Please see cordovaIonicDemoApp folder for example on Ionic
https://github.com/GetMati/mati-mobile-examples/tree/main/cordovaIonicDemoApp

# Additional info

## Android
You have to check your project: YourProject/platforms/android/mati-global-id-sdk-cordova-plugin/demoCordovaMati-build.gradle

```
dependencies {
implementation 'com.getmati:mati-sdk:HERE_IS_LATEST_VERSION'
}
```
Check this for latest version: 
https://search.maven.org/artifact/com.getmati/mati-sdk

 
### Set AndroidX support into config.xml for cordova project
<platform name="android">
	<preference name="AndroidXEnabled" value="true" />
</platform>

### iOS

In the IOS platform find the Podfile file. 
The targeted OS version should be a minimum of 11.4.

Run "pod install" to fetch the project dependencies.

The following permissions are needed to capture video and access the photo gallery.

For voiceliveness feature please add NSMicrophoneUsageDescription

### Info.plist

```
<key>NSCameraUsageDescription</key>
<string>Mati needs access to your Camera</string>
<key>NSPhotoLibraryUsageDescription</key>
<string>Mati needs access to your media library</string>
<key>NSMicrophoneUsageDescription</key>
<string>Mati needs access to your Microphone</string>
```
### Make sure that you are using the latest version our sdk

You have to check your project: YourProject/platforms/ios/Podfile

```
platform :ios, '11.4'
target 'demoCordovaMati' do
    pod 'Mati-Global-ID-SDK'
end
```
Check this for latest version: 
https://cocoapods.org/pods/Mati-Global-ID-SDK

# Please see cordovaIonicDemoApp folder for example
https://github.com/GetMati/mati-mobile-examples/tree/main/cordovaIonicDemoApp

## Have any questions? Feel free create issue here.


