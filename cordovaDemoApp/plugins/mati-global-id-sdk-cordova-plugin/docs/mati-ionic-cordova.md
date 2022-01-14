---
title: "Ionic Cordova"
excerpt: "Add the MetaMap button to your Cordova app."
slug: "ionic-cordova-sdk"
category: 61ae8e8dba577a0010791480
---

# Mati for Ionic Cordova Usage Guide

This is a usage guide to implement Mati for [Ionic for Cordova framework](https://ionicframework.com/docs/v1/guide/preface.html) for the following platforms:

* [Cordova](#cordova)
* [Ionic](#ionic-cordova)
* [Android](#android)
* [iOS](#ios)

_**Note**_ This usage guide is for Cordova version 6.x+ with a recommendation of Cordova version 10.

## Cordova Demo App

You can go to GitHub to download the [Mati Cordova demo app](https://github.com/GetMati/mati-mobile-examples/tree/main/cordovaDemoApp) or the [Mati Ionic Cordova demo app](https://github.com/GetMati/mati-mobile-examples/tree/main/cordovaIonicDemoApp).

## Cordova

### Install Mati for Cordova

In a terminal, install Mati for Cordova:

```bash
cordova plugin add https://github.com/GetMati/mati-cordova-plugin.git
```

#### Upgrade Mati for Cordova
To upgrade to the latest version of Mati for Cordova, you will need first uninstall your current version:

```bash
cordova plugin remove mati-global-id-sdk-cordova-plugin
```

Then install the latest Mati version:
```bash
cordova plugin add https://github.com/GetMati/mati-cordova-plugin.git
```

### Add Mati to Your Cordova App

You will need to update your HTML and JavaScript files to add the Mati button to your Cordova application:

* [HTML](#cordova-html)
* [JavaScript](#cordova-javascript)

<a id="cordova-html"></a>
#### HTML

Add the Mati button to your HTML file:

**HTML Example for Cordova**
```
 <input
     class="matiButton"
     id="matiButton"
     type="button"
     value="show Mati Flow"
     />
 ```

<a id="cordova-javascript"></a>
#### JavaScript

Add the Mati button in your JavaScript file `index.js`:


**JavaScript Example for Cordova**

```js
function onDeviceReady() {

//trigger login on button click
var matiButton = document.getElementById("matiButton");

  matiButton.onclick = () => {
      //set 3 params clientId (cant be null), flowId, metadata
      var yourMetadata = { param1: "value1", param2: "value2" }
      var matiButtinParams = { clientId: "YOUR_CLIENT_ID", flowId: "YOUR_FLOW_ID", metadata: yourMetadata }
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

## Ionic Cordova

### Install Mati for Ionic Cordova

In a terminal, install Mati for Ionic Cordova:

```bash
ionic cordova plugin add  https://github.com/GetMati/mati-cordova-plugin.git
```

#### Upgrade Mati for Ionic Cordova
To upgrade to the latest version of Mati for Cordova, you will need first uninstall your current version:

```bash
ionic cordova plugin remove mati-global-id-sdk-cordova-plugin
```
Then install the latest Mati version:

```bash
ionic cordova plugin add  https://github.com/GetMati/mati-cordova-plugin.git
```

### Add Mati to Your Ionic Cordova App

You will need to update your HTML and TypeScript files to add the Mati button to your Cordova application:

* [HTML](#ionic-cordova-html)
* [Type Script](#ionic-cordova-typescript)

<a id="ionic-cordova-html"></a>
#### HTML

**HTML Example for Ionic Cordova**
```html
 <input
    class="matiButton"
    id="matiButton"
    type="button"
    value="show Mati Flow"
    ion-item (click)="showMatiFlow()"/>
 ```
<a id="ionic-cordova-typescript"></a>
#### TypeScript

**TypeScript Example for Ionic Cordova: home.page.ts**
```ts
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

## Android

Download the latest version of Mati for Android [here](https://search.maven.org/artifact/com.getmati/mati-sdk).

1. Check that your project's Gradle file (`<YourProject>/platforms/android/mati-global-id-sdk-cordova-plugin/<demoCordovaMati-build>.gradle`) uses the latest version of Mati for Cordova:

    ```java
    dependencies {
      implementation 'com.getmati:mati-sdk:<LATEST_VERSION>'
    }
    ```

1. Enable AndroidX support in `config.xml`.

   ```xml
   <platform name="android">
   	<preference name="AndroidXEnabled" value="true" />
   </platform>
   ```

## iOS

The following instructions are for iOS version 12.0 or higher.
1.  The latest version of Mati for iOS: https://cocoapods.org/pods/Mati-Global-ID-SDK.
  You can also check your podfile for version information. For example:
    ```ruby
    platform :ios, '12.0'
    target 'demoCordovaMati' do
        pod 'Mati-Global-ID-SDK'
    end
    ```
1. In the iOS directory find the podfile and install:
  `pod install`
1. In the `info.plist` file, add the following permissions to capture video, access the photo gallery, and capture audio for voiceliveness:
  **Info.plist**

    ```xml
    <key>NSCameraUsageDescription</key>
    <string>Mati needs access to your Camera</string>
    <key>NSPhotoLibraryUsageDescription</key>
    <string>Mati needs access to your media library</string>
    <key>NSMicrophoneUsageDescription</key>
    <string>Mati needs access to your Microphone</string>
    ```
