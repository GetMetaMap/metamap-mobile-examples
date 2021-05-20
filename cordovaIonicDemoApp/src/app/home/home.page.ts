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
    console.log("test 1");
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
    console.log("test 2");
    cordova.plugins.MatiGlobalIDSDK.showMatiFlow();
  }

}
