//
//  MatiRequestManager.swift
//  MatiGlobalIDSDK
//
//  Created by Andrey Posnov on 1/25/21.
//  Copyright © 2021 Mati. All rights reserved.
//

import Foundation

class RequestManager {
    private static var sharedInstance: RequestManager?
      class var shared : RequestManager {
          guard let sharedInstance = self.sharedInstance else {
              let sharedInstance = RequestManager()
              self.sharedInstance = sharedInstance
              return sharedInstance
          }
          return sharedInstance
      }
    
    private let socketManager = MetaMapSocketManager()
    private let apiManager = MetaMapApiManager()

    func getToken(completion: @escaping (IdTokenResponseModel?) -> Void) {
        apiManager.getToken(completion: { (oauth) in
            if let oauth = oauth {
                if let token = oauth.accessToken {
                    StorageManager.shared.set(token, for: .accessToken)
                }
                if let idToken = oauth.idToken?.components(separatedBy: ".") {
                    if idToken.count > 1 {
                        let payloadEncoded = idToken[1]
                        if let payloadFix = payloadEncoded.base64JwtDecode() {
                            let jsonData = Data(payloadFix.utf8)
                            if let idTokenModel = try? IdTokenResponseModel.decode(from: jsonData) {
                                completion(idTokenModel)
                            } else {
                                completion(nil)
                            }
                        } else {
                            completion(nil)
                        }
                    }
                } else { // idtoken slice from whole
                    completion(nil)
                }
            } else { // oauth
                completion(nil)
            }
        })
    }

    func uploadFile(fileData: FileUploadModelProtocol, completion: @escaping (ResponseStatus) -> Void, progressHandler: ((_ progress: CGFloat) -> Void)? = nil)  {
        apiManager.uploadFileRequest(fileData: fileData, completion: completion, progressHandler: progressHandler)
    }
    
    func creditCheckSubmit(data: CreditCheck, completion: @escaping (ResponseStatus) -> Void) {
        apiManager.creditCheckRequest(data: data, completion: completion)
    }
    
    func customDocSkip(data: SkipHeaderData, completion: @escaping (ResponseStatus) -> Void) {
        apiManager.skipStepsRequest(data: data, type: .customDocumentSkip, completion: completion)
    }
    
    func docBackSideSkip(data: DocBackSideSkip, completion: @escaping (ResponseStatus) -> Void) {
        apiManager.skipStepsRequest(data: data, type: .documentSkip, completion: completion)
    }
    
    func skipInput(input: InputId, completion: @escaping (ResponseStatus) -> Void)  {
        apiManager.skipStepsRequest(data: nil, type: .skip(subType: input.rawValue), completion: completion)
    }
    
    func downloadPDF(path: String, completion: @escaping (ResponseStatus, Data?) -> Void) {
        apiManager.downloadPDF(path: path, completion: completion)
    }
    
    func sendSignalData(data: [String: Any]) {
        apiManager.sendSignalData(body: data)
    }
    
    func vpnRetry(completion: @escaping (ResponseStatus) -> Void) {
        apiManager.vpnTryAgain(completion: completion)
    }
    
    func uploadInput(inputData: InputDataProtocol, completion: @escaping (ResponseStatus) -> Void)  {
        apiManager.uploadInputRequest(inputData: inputData, completion: completion)
    }
    
    func sendLocationData(inputData: InputDataProtocol, completion: @escaping (ResponseStatus) -> Void) {
        apiManager.sendLoation(inputData: inputData, completion: completion)
    }
    
    func downloadImagefromUrl(path: String?, completion: @escaping (ResponseStatus ,UIImage?) -> Void) {
        guard let path = path, !path.isEmpty, let url = URL(string: path) else {
            completion(.error(error: nil), nil)
            return
        }
        socketManager.getData(from: url) { data, response, error in
            guard let data = data, let image = UIImage(data: data) else {
                completion(.error(error: error as? NSError), nil)
                return
            }
            completion(.success, image)
        }
    }
    
    func closeWebSocketConnection() {
        socketManager.closewWsConnection()
    }
    
    func sendAnalyticEvent(eventName: String, details: Codable) {
        socketManager.sendAnalyticEvent(eventName: eventName, details: details)
    }
    
    func createVerification(flowId: String, completion: @escaping (Bool) -> Void) {
        apiManager.createVerificationRequest(flowId: flowId) { data in
            guard let verification = data else { return }
            guard let verificationId = verification.id else { return }
            MetaMapGlobalManager.instance.verificationId = verificationId
            MetaMapGlobalManager.instance.identity = verification.identity
            MetaMapGlobalManager.instance.checkCreditCard(inputs: verification.inputs)
            self.socketManager.openWsConnection(flowId: flowId, method: API.Path.wsVerificationFlow.value, completion: completion)
        }
    }
}

