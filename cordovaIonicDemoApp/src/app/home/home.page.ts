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
    var yourMetadata = { param1: "value1", param2: "value2" };
    var matiParams = { clientId: "YOUR_CLIENT_ID", flowId: "YOUR_FLOW_ID", metadata: yourMetadata };
    cordova.plugins.MatiGlobalIDSDK.showMatiFlow(matiParams);
  }

}
