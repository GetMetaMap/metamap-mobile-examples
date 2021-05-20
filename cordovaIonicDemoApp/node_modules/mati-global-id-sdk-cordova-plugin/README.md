# Mati Cordova plugin Android And IOS SDK documentation

Create a new Cordova project or Ionic project
Add the SDK plugin with the following command

cordova plugin add https://github.com/GetMati/mati-cordova-plugin.git

## Create html

In your project add a button to trigger the login process.

## Mati SDK initialization
## Cordova.

Initialize Mati by calling the following line of code:

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
//set 3 params clientId (cant be null), flowId, metadata 
var matiParams = { clientId: "YOURS_CLIENT_ID", flowId: "YOURS_FLOW_ID", metadata: YOURS_METADATA }
cordova.plugins.MatiGlobalIDSDK.setParams(matiParams);
 
//set trigger login on button click
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
 ```

##IOS build

In the IOS platform find the Podfile file. The targeted OS version should be a minimum of 9. Run "pod install" to fetch the project dependencies.

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

# Android

You have to check your project: YourProject/platforms/android/mati-global-id-sdk-cordova-plugin/demoCordovaMati-build.gradle

```
dependencies {
implementation 'com.matilock:mati-global-id-sdk:HERE_IS_LATEST_VERSION'
}
```
Check this for latest version: 
https://bintray.com/matibiometricskyc/maven/mati-global-id-sdk

### Change public class CordovaActivity
 CordovaActivity extends AppCompatActivity 
 
### Set AndroidX support to true 
android.useAndroidX=true
android.enableJetifier=true

# iOS

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



