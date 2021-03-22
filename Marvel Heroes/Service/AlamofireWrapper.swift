//
//  AlamofireWrapper.swift
//  Marvel Heroes
//
//  Created by Andreas Velounias on 22/03/2021.
//

import Foundation
import Alamofire

class AlamofireWrapper: AlamofireProtocol {

    var manager: Alamofire.SessionManager
    
    init() {
        let serverTrustPolicies: [String: ServerTrustPolicy] = [
            "gateway.marvel.com": .disableEvaluation
        ]
        // Create custom manager
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        manager = Alamofire.SessionManager(
            configuration: URLSessionConfiguration.default,
            serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies)
        )
    }
    
    func responseString(
        _ url: String,
        method: HTTPMethod,
        parameters: Parameters?,
        encoding: ParameterEncoding,
        completionHandler: @escaping (DataResponse<String>) -> Void
    ) {
        manager.request(url, method: method, parameters: parameters, encoding: encoding).responseString(completionHandler: completionHandler)
    }

}
