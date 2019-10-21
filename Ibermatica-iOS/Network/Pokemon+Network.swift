//
//  Pokemon+Network.swift
//  Ibermatica-iOS
//
//  Copyright © 2019 Albert. All rights reserved.
//

import Alamofire
import RealmSwift
import SwiftyJSON

extension Pokemon {
    
    public static func all(_ completion: @escaping(_ success: Bool, _ error: Error?) -> ()) -> DataRequest {
        
        return NetworkProvider<PokemonSpecs>.requestString(.all, { (response, specs) in
        

            switch response.result {
            case .success(_):
                do {
                    // Get response data
                    guard let data = response.data else {
                        completion(false, response.error)
                        return
                    }
                    
                    guard let pokemonsJSON = try JSON(data: data)["results"].array else { return }

                    var pokemons: [Pokemon] = []
                    for id in 0 ..< pokemonsJSON.count {

                        let pokemonJSON = pokemonsJSON[id]
                        
                        pokemons.append(Pokemon(id, json: pokemonJSON))
                        
                    }
                    let realm = try Realm()
                    try realm.write({
                        realm.add(pokemons, update: .all)
                    })
                    
                    completion(true, nil)
                } catch {
                    completion(false, error)
                }
                
            case .failure(let error):
                completion(false, error )
            }
            
        })
        
    }
    
}
