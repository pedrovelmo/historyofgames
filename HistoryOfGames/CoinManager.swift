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
    
    case threeBySeven = 0
}

let coinManager = CoinManager()

class CoinManager{
    
    class var sharedInstance: CoinManager{
        return coinManager
    }
    
    var scene: SKScene?
    
    func instantiateCoinPattern(pattern: Int, scene: SKScene) -> [Coin] {
        
        let sceneWidth = scene.size.width
        let sceneHeight = scene.size.height
        var coinVector: [Coin] = []
        let spaceBetweenCoins: CGFloat = 5
        
        switch pattern{
            case CoinPatterns.threeBySeven.rawValue:
               
                for row in 0...2 {
                    for col in 0...6 {
                        
                        let coin = Coin()
 
                        coin.size = CGSize(width: scene.size.height * 0.06, height: scene.size.height * 0.06)
                        coin.position.x = sceneWidth + (coin.size.width + spaceBetweenCoins) * CGFloat(col)
                        coin.position.y = sceneHeight / 2 + (coin.size.height + spaceBetweenCoins) * CGFloat(row)
                        coinVector.append(coin)
                        
                    }
            }
            
        default:
            break
        }
        
     return coinVector
    }
}
