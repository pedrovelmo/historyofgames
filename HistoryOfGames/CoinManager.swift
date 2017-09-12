//
//  CoinManager.swift
//  HistoryOfGames
//
//  Created by Gabriel Rezende on 12/09/17.
//  Copyright © 2017 adabestgroup. All rights reserved.
//

import Foundation
import SpriteKit

public enum CoinPatterns: Int{
    
    case threeByFour = 0
}

let coinManager = CoinManager()

class CoinManager{
    
    class var sharedInstance: CoinManager{
        return coinManager
    }
    
    var scene: SKScene?
    
    var coinMatrix: [[Coin]] = [[],[]]
    
    func instantiateCoinPattern(pattern: Int){
        
        switch pattern{
            
            
        case CoinPatterns.threeByFour.rawValue:
            break
            
        default:
            break
        }
    }
}
