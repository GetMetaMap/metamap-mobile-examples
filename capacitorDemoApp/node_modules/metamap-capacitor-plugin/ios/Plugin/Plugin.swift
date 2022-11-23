import Foundation
import Capacitor
import MetaMapSDK

/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitorjs.com/docs/plugins/ios
 */
@objc(MetaMapCapacitorPlugin)
public class MetaMapCapacitorPlugin: CAPPlugin {

    var output:  CAPPluginCall?
    @objc func showMetaMapFlow(_ call: CAPPluginCall) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            var metadata = call.getObject("metadata") ?? [:]
            metadata["sdk_type"] = "capacitor"
            MetaMap.shared.showMetaMapFlow(clientId: call.getString("clientId") ?? "",
                                    flowId: call.getString("flowId") ?? "",
                                    metadata: metadata)
            MetaMapButtonResult.shared.delegate = self
           self.output = call
        }
    }
}

extension MetaMapCapacitorPlugin: MetaMapButtonResultDelegate {
    public func verificationSuccess(identityId: String?, verificationID: String?) {
        debugPrint("verificationSuccessIdentityId : \(identityId)")
        output?.resolve(["identityId": identityId, "verificationID": verificationID])
        debugPrint("verificationSuccessVerificationID: \(verificationID)")
    }
        
    public func verificationCancelled() {
        debugPrint("verificationCancelled")
        output?.reject("verificationCancelled")
    }
}
