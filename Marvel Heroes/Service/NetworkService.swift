//
//  NetworkService.swift
//  Marvel Heroes
//
//  Created by Andreas Velounias on 22/03/2021.
//

import Foundation
import Alamofire

class NetworkService: NetworkProtocol {
    
    static let shared = NetworkService()

    private init() {}
    
    var alamofireWrapper: AlamofireProtocol?
    
    var authPath: String {
        get {
            let hash: String = (Constants.TS+Constants.PRIVATE_KEY+Constants.PUBLIC_KEY).md5().lowercased()
            return "ts=\(Constants.TS)&apikey=\(Constants.PUBLIC_KEY)&hash=\(hash)"
        }
    }
    
    var baseUrl: String {
        get {
            return "https://gateway.marvel.com/v1/public/"
        }
    }
    
    private func treatError(url: String, response: DataResponse<String>) -> String{
        if let localizedDescription = response.result.error?.localizedDescription {
            return localizedDescription
        } else if response.result.debugDescription.count > 0 {
            return response.result.debugDescription
        }
        return "error: \(response.response?.statusCode ?? 0)"
    }
    
    func request(
        url: String,
        method: HTTPMethod,
        parameters: Parameters? = nil,
        complete: @escaping ( ServiceResult<String?> ) -> Void )
    {
        guard let wrapper = alamofireWrapper else {
            return complete(.Error("Error creating request", 0))
        }

        wrapper.responseString(url, method: method, parameters: parameters, encoding: JSONEncoding.default)
        { [weak self] response in
            let statusCode = response.response?.statusCode ?? -1
            if response.result.isSuccess {
                return complete(.Success(response.result.value, statusCode))
                
            }
            return complete(.Error(self?.treatError(url: url, response: response) ?? "", response.response?.statusCode))
        }

    }
}
