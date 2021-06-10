import { Component } from '@angular/core';
import { Plugins } from '@capacitor/core';

const { MatiCapacitorPlugin } = Plugins;

@Component({
  selector: 'app-tab1',
  templateUrl: 'tab1.page.html',
  styleUrls: ['tab1.page.scss']
})

export class Tab1Page {
  constructor() {}

  // the method that starts to show FLOW screens
  showMatiFlow() {
    let metadataParams = { param1: "value1" }; // variable for metadata params
    let registerParams = { clientId: "YOUR_CLIENT_ID", flowId: "YOUR_FLOW_ID", metadata: metadataParams}; // variable for register params
    MatiCapacitorPlugin.showMatiFlow(registerParams);
  }

  ionViewDidEnter() {
    // methods handle of result
    window.addEventListener('Verification success', (verificationId) => {
      console.log("verification success:" + verificationId)
    });

    window.addEventListener('Verification cancelled', () => {
      console.log("verification cancelled")
    });
  }
}
