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
    cordova.plugins.MetaMapGlobalIDSDK.setMetaMapCallback(
      (params) => {
        console.log('setMetaMapCallback success: ' + params.identityId);
        console.log('setMetaMapCallback success: ' + params.verificationID);
      },
      (error) => {
        console.log('setMetaMapCallback error: ' + error);
      }
    );
  }

  showMetaMapFlow() {
    //set 3 params clientId (cant be null), flowId, metadata
    var yourMetadata = { param1: 'value1', param2: 'value2' };
    var metaMapButtinParams = {
      clientId: 'YOUR_CLIENT_ID',
      flowId: 'YOUR_FLOW_ID',
      metadata: yourMetadata,
    };
    cordova.plugins.MetaMapGlobalIDSDK.showMetaMapFlow(metaMapButtinParams);
  }
}
