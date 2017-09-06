//
//  Extensions.swift
//  HistoryOfGames
//
//  Created by Gabriel Rezende on 05/09/17.
//  Copyright © 2017 adabestgroup. All rights reserved.
//

import Foundation

extension Array {
    mutating func rearrange(from: Int, to: Int) {
        precondition(from != to && indices.contains(from) && indices.contains(to), "invalid indexes")
        insert(remove(at: from), at: to)
    }
    var lastIndex:Int {
        get {
            return self.count - 1
        }
    }
}
