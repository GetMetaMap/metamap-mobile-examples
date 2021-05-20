# Cordova&Ionic plugin for Mati SDK

Create a new Cordova project or Ionic project
Add the SDK plugin with the following command

cordova plugin add https://github.com/GetMati/mati-cordova-plugin.git


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

//set 3 params clientId (cant be null), flowId, metadata 
var matiParams = { clientId: "YOURS_CLIENT_ID", flowId: "YOURS_FLOW_ID", metadata: YOURS_METADATA }
cordova.plugins.MatiGlobalIDSDK.setParams(matiParams);
 
//trigger login on button click
var matiButton = document.getElementById("matiButton");

matiButton.onclick = () => {
  cordova.plugins.MatiGlobalIDSDK.showMatiFlow();
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
cordovaDemoApp

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
    
    //set 3 params clientId (cant be null), flowId, metadata 
    var matiParams = { clientId: "YOUR_CLIENT_ID", flowId: "YOUR_FLOW_ID", metadata: YOUR_METADATA }
    cordova.plugins.MatiGlobalIDSDK.setParams(matiParams);

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
    cordova.plugins.MatiGlobalIDSDK.showMatiFlow();
  }

}
 ```
 
## Please see demoIonicStart folder for example on Ionic
demoIonicStart

# Additional info

## Android
You have to check your project: YourProject/platforms/android/mati-global-id-sdk-cordova-plugin/demoCordovaMati-build.gradle

```
dependencies {
implementation 'com.matilock:mati-global-id-sdk:HERE_IS_LATEST_VERSION'
}
```
Check this for latest version: 
https://bintray.com/matibiometricskyc/maven/mati-global-id-sdk


## Please change public class CordovaActivity.java
Before CordovaActivity.java
 ```
public class CordovaActivity extends Activity {
```
After CordovaActivity.java
```
public class CordovaActivity extends AppCompatActivity {
```
Changes in manifest, please set theme to MainActivity
```
 android:theme="@style/Theme.AppCompat" 
```
 
### Set AndroidX support to true 
android.useAndroidX=true

android.enableJetifier=true

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

# Please see cordovaDemoApp folder for example
cordovaDemoApp

## Have any questions? Feel free create issue here.


