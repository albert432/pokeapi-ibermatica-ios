//
//  Pokemon.swift
//  Ibermatica-iOS
//
//  Copyright © 2019 Albert. All rights reserved.
//

import RealmSwift
import SwiftyJSON

final class Pokemon: Object {
    
    @objc dynamic var id = -1
    @objc dynamic var name = ""
    @objc dynamic var url = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(_ id: Int, name: String, url: String) {
        self.init()
        self.id = id
        self.name = name
        self.url = url
    }
    
    convenience init (_ id: Int, json: JSON) {
        self.init()
        
        self.id = id+1
        self.name = json["name"].stringValue
        self.url = json["url"].stringValue
    }
}
