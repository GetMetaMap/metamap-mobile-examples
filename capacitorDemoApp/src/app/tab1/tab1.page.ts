import { Component } from '@angular/core';
import { MetaMapCapacitor } from "metamap-capacitor-plugin";

@Component({
  selector: 'app-tab1',
  templateUrl: 'tab1.page.html',
  styleUrls: ['tab1.page.scss']
})

export class Tab1Page {

  constructor() {}

  showMetaMapFlow() {
      let metadataParams = { param1: "value1" };
      let registerParams = { clientId: "YOUR_CLIENT_ID", flowId: "YOUR_FLOW_ID", metadata: metadataParams};

      MetaMapCapacitor.showMetaMapFlow(registerParams)
        .then( verification => console.log("verification success:" + verification.verificationID))
        .catch(() => console.log("verification cancelled"))
    }

}
