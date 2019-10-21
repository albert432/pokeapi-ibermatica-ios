//
//  NetworkProvider.swift
//  Ibermatica-iOS
//
//  Copyright © 2019 Albert. All rights reserved.
//

import Alamofire

/// The protocol used to define the specifications necessary for a 'NetworkProvider'.
public protocol NetworkProviderSpecs {
    
    /// The provider's 'baseURLString'.
    var baseURLString: String { get }
    
    /// The path to be appended to 'baseURLString' to form the full 'URL'.
    var path: String { get }
    
    /// The HTTP method used in the request.
    var method: Alamofire.HTTPMethod { get }
    
    /// The headers to be added in the request.
    var headers: [String: String]? { get }
    
    /// The parameters to be incoded in the request.
    var parameters: [String: Any]? { get }
    
    /// The method used for parameter encoding.
    var parameterEncoding: ParameterEncoding { get }
    
}

// Network provider
public class NetworkProvider<T:NetworkProviderSpecs> {
    
    public static func requestJSON(_ endpoint: T, _ completionHandler:@escaping(DataResponse<Any>, NetworkProviderSpecs) -> ())
        -> DataRequest {

            return Alamofire
                .request(endpoint.path, method: endpoint.method, parameters: endpoint.parameters, encoding: endpoint.parameterEncoding, headers: endpoint.headers)
                .validate()
                .responseJSON(completionHandler: { (response) in
                    completionHandler(response, endpoint)
                })
            
    }
    
    public static func requestString(_ endpoint: T, _ completionHandler:@escaping(DataResponse<String>, NetworkProviderSpecs) -> ())
        -> DataRequest {
        
            return Alamofire
                .request(endpoint.path, method: endpoint.method, parameters: endpoint.parameters, encoding: endpoint.parameterEncoding, headers: endpoint.headers)
                .validate()
                .responseString(completionHandler: { (response) in
                    completionHandler(response, endpoint)
                })
    }
}
