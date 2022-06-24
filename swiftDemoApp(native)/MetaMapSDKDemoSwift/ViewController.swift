//
//  ViewController.swift
//  MetaMapKYCSDKDemoSwift
//
//  Created by Avo Sukiasyan on 27/03/22.
//  Copyright © 2019 Avo Sukiasyan. All rights reserved.
//

import UIKit
import MetaMapSDK

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupMetaMapButton()
    }

    private func setupMetaMapButton() {

      //init button
      let metaMapButton = MetaMapButton()

      //add button action
            metaMapButton.addTarget(self, action: #selector(self.metaMapButtonAction), for: .touchUpInside)

      //set view of button
            metaMapButton.frame = CGRect(x: 20, y: self.view.frame.size.height/2 - 50, width: view.frame.size.width - 40, height: 50)

      //add button to yours view
      view.addSubview(metaMapButton)

      //set delegate to get result
      MetaMapButtonResult.shared.delegate = self

    }

      @objc private func metaMapButtonAction() {
    //set params to showMetaMapFlow
    MetaMap.shared.showMetaMapFlow(clientId: "YOUR_CLIENT_ID",
                flowId: "YOUR_FLOW_ID",
                metadata: ["key1": "value1", "key2": 123])
    }
}

//MARK: MetaMapButtonResultDelegate
extension ViewController: MetaMapButtonResultDelegate {

    func verificationSuccess(identityId: String?, verificationID: String?) {
        print("MetaMap Verification Success \(identityId)")
    }

    func verificationCancelled() {
        print("MetaMap Verification Cancelled")
    }
}
