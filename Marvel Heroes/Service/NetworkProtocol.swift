//
//  NetworkProtocol.swift
//  Marvel Heroes
//
//  Created by Andreas Velounias on 22/03/2021.
//

import Alamofire

enum ServiceResult<T> {
    case Success(T, Int)
    case Error(String, Int?)
}

protocol NetworkProtocol {

    var authPath: String { get }
    
    var baseUrl: String { get }

    func request(
        url: String,
        method: HTTPMethod,
        parameters: Parameters?,
        complete: @escaping ( ServiceResult<String?> ) -> Void )
    
}
