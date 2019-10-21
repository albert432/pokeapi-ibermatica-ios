//
//  PokemonSpecs.swift
//  Ibermatica-iOS
//
//  Copyright © 2019 Albert. All rights reserved.
//

import Alamofire

// MARK: - Provider specs
enum PokemonSpecs {
    case all
}

extension PokemonSpecs: NetworkProviderSpecs {
    
    var baseURLString: String {
        return "https://pokeapi.co/api/v2/"
    }
    
    var path: String {
        switch self {
        case .all:
            return baseURLString + "pokemon/?limit=-1"
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



