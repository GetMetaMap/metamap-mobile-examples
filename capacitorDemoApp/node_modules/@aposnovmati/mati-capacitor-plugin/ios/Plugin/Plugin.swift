import Foundation
import Capacitor
import MatiSDK

/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitorjs.com/docs/plugins/ios
 */
@objc(MatiCapacitorPlugin)
public class MatiCapacitorPlugin: CAPPlugin {
    
    private var matiButton: MatiButton?
    
    @objc func setParams(_ call: CAPPluginCall) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.matiButton = MatiButton()
            self.matiButton?.setParams(clientId:  call.getString("clientId") ?? "",
                                       flowId: call.getString("flowId") ?? "",
                                       metadata: call.getObject("metadata") ?? nil)
            call.success()
        }
    }
    
    @objc func showMatiFlow(_ call: CAPPluginCall) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.matiButton?.sendActions(for: .touchUpInside)
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
