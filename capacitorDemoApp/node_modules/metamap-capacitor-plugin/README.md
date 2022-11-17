---
title: "Capacitor"
excerpt: "Add the MetaMap button to your Capacitor app."
slug: "capacitor-sdk"
category: 61ae8e8dba577a0010791480
---


| LTS version (Recommended for most users): | Current Version(Latest features) |
|-------------------------------------------|----------------------------------|
| 3.7.6                                    |3.7.6                          |


# Metamap for Capacitor Usage Guide

This is a guide to implement Metamap in the [Ionic Capacitor framework](https://capacitorjs.com/docs).

## Capacitor Demo App

You can go to GitHub to download the [Metamap Capacitor demo app](https://github.com/GetMati/mati-mobile-examples/tree/main/capacitorDemoApp).

## Install Metamap for Capacitor

The following instructions use command line tools to install Metamap for Capacitor to your existing Capacitor application.

1. Use the following CLI to install Metamap for your Capacitor project.
```bash
npm i metamap-capacitor-plugin@3.7.6
 ```

1. Build your application.
```bash
ionic build
 ```

1. Update the Capacitor files.
```bash
npx cap sync
```

## Add the Metamap Button

Add the Metamap button to your application's HTML and JavaScript files.

`your_index.html`

```html
<ion-content>
   <ion-button className="matiButtonCss" (click)="showMatiFlow()">Show MatiFlow
   </ion-button>
</ion-content>
```

 `your_index.ts`

```json
import { Component } from '@angular/core';

import { MetaMapCapacitor } from "metamap-capacitor-plugin";

@Component({
  selector: 'app-home',
  templateUrl: 'home.page.html',
  styleUrls: ['home.page.scss'],
})
export class HomePage {
  constructor() {}

  showMatiFlow() {
    let metadataParams = { param1: "value1" };
    let registerParams = { clientId: "5c94e3c401ddc6001be83c07", flowId: "5e962a23728ddc001b5937aa", metadata: metadataParams};

    MatiCapacitor.showMatiFlow(registerParams)
      .then( verification => console.log("verification success:" + verification.verificationId))
      .catch(() => console.log("verification cancelled"))
  }
}
```

## Launch for Android

```bash
ionic capacitor run android
```

# Launch for iOS

1. Set minimum iOS version in `capacitor.config.json`
```json
     "ios": {
      "minVersion": "12.0"
    }
```

1. Add the following to info.plist:
```bash
    <key>NSCameraUsageDescription</key>
    <string>MetaMap verification SDK requires camera use</string>

    <key>NSMicrophoneUsageDescription</key>
    <string>MetaMap verification SDK requires microphone use</string>

    <key>NSPhotoLibraryUsageDescription</key>
    <string>MetaMap verification SDK requires access to media library</string>

    <key>NSLocationWhenInUseUsageDescription</key>
    <string>MetaMap will use your location information to provide best possible verification experience.</string>

    <key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
    <string>MetaMap will use your location information to provide best possible verification experience.</string>

    <key>NSLocationAlwaysUsageDescription</key>
    <string>MetaMap will use your location information to provide best possible verification experience.</string>
  ```

1. Launch the application for iOS
```bash
ionic capacitor run ios
  ```

## Metadata is an additional optional parameters:

1. Set the Language:
```bash
metadata: {"fixedLanguage": "es"}
```

1.  Set the Button Color:
```bash
metadata: {"buttonColor": "hexColor"}
```

1. Set the Title color of the button:
```bash
metadata: {"buttonTextColor": "hexColor"}
   ```
   
1. Set identity Id as parameter for re-verification:
```bash
metadata: {"identityId": "value"}
```


## Some error codes you may get during integration

`402` - MetaMap services are not paid: please contact your customer success manager

`403` - MetaMap credentials issues: please check your client id and MetaMap id