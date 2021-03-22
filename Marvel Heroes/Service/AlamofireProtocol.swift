//
//  AlamofireProtocol.swift
//  Marvel Heroes
//
//  Created by Andreas Velounias on 22/03/2021.
//

import Alamofire

protocol AlamofireProtocol {
    
    func responseString(
        _ url: String,
        method: HTTPMethod,
        parameters: Parameters?,
        encoding: ParameterEncoding,
        completionHandler: @escaping (DataResponse<String>) -> Void
    )

}
