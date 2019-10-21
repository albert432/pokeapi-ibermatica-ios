//
//  DetailSpecs.swift
//  Ibermatica-iOS
//
//  Copyright © 2019 Albert. All rights reserved.
//

import Alamofire

// MARK: - Provider specs
enum DetailSpecs {
    case all(id: Int)
}

extension DetailSpecs: NetworkProviderSpecs {
    
    var baseURLString: String {
        return "https://pokeapi.co/api/v2/"
    }
    
    var path: String {
        switch self {
        case .all(let id):
            return baseURLString + "pokemon/\(id)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .all:
            return .get
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .all:
            return ["Content-Type": "application/json"]
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .all:
            return [:]
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        switch self {
        case .all:
            return URLEncoding.default
        }
    }
    
    
}




