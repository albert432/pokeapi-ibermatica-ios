//
//  Pokemon+Local.swift
//  Ibermatica-iOS
//
//  Copyright © 2019 Albert. All rights reserved.
//

import RealmSwift

extension Pokemon {
    static var all: Results<Pokemon> {
        return try! Realm().objects(self)
    }
}
