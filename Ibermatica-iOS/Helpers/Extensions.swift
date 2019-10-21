//
//  Extensions.swift
//  Ibermatica-iOS
//
//  Copyright © 2019 Albert. All rights reserved.
//

import Foundation

extension String {
    func fromTable(_ tableName: String) -> String {
        return NSLocalizedString(self, tableName: tableName, comment: "")
    }
}
