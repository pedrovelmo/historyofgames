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
    
    
    func instantiateCoinPattern(pattern: Int, scene: SKScene) -> [Coin] {
        
     
        
        let sceneWidth = scene.size.width
        var coinVector: [Coin] = []
        
        switch pattern{
            case CoinPatterns.threeByFour.rawValue:
                //let matrix = Matrix(rows: 3, columns: 4)
               
                for row in 0...2 {
                    for col in 0...3 {
                        
                        let coin = Coin()
                        coin.position.x = sceneWidth + coin.size.width * CGFloat(row)
                        coin.position.x = coin.position.x + coin.size.height * CGFloat(col) + coin.size.width / 2
                        coin.position.y = coin.size.width * CGFloat(row)
                        coin.position.y = coin.position.y + coin.size.height * CGFloat(col) + coin.size.height / 2
                        coinVector.append(coin)
                        
                        
                    }
            }
        
            
        default:
            break
        }
     return coinVector
    }
}
