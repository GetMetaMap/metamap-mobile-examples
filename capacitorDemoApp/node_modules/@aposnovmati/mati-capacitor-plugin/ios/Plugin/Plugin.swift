import Foundation
import Capacitor
import MatiSDK

/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitorjs.com/docs/plugins/ios
 */
@objc(MatiCapacitorPlugin)
public class MatiCapacitorPlugin: CAPPlugin {
    
    @objc func showMatiFlow(_ call: CAPPluginCall) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            let metadata = call.getObject("metadata") ?? [:]
            metadata["sdk_type"] = "ios_capacitor"
            Mati.shared.showMatiFlow(clientId: call.getString("clientId") ?? "",
                                    flowId: call.getString("flowId") ?? "",
                                    metadata: )
            MatiButtonResult.shared.delegate = self
            call.success()
        }
    }
}

extension MatiCapacitorPlugin: MatiButtonResultDelegate {
    public func verificationSuccess(identityId: String) {
        self.bridge.triggerWindowJSEvent(eventName:  "verificationSuccess:", data: identityId)
        debugPrint("verificationSuccess: \(identityId)")
    }
    
    public func verificationCancelled() {
        self.bridge.triggerWindowJSEvent(eventName: "verificationCancelled")
        debugPrint("verificationCancelled")
    }
}
