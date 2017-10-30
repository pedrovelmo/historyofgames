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
    case twoByNine = 1
}

let coinManager = CoinManager()

class CoinManager{
    
    class var sharedInstance: CoinManager{
        return coinManager
    }
    
    var scene: SKScene?
    var coinVector: [Coin] = []
    var patternVector: [[Coin]] = [[]]
    
    func instantiateCoinPattern(pattern: Int, scene: SKScene){
        
        coinVector = []
        self.scene = scene
        
        switch pattern{
            
            case CoinPatterns.threeBySeven.rawValue:
            
                setCoins(row: 3, column: 7)
            
            case CoinPatterns.twoByNine.rawValue:
            
                setCoins(row: 2, column: 9)
            
        default:
            break
        }
    }
    
    func setCoins(row: Int, column: Int){
        
        let sceneWidth = scene?.size.width
        let sceneHeight = scene?.size.height
        let spaceBetweenCoins: CGFloat = 5
        
        let randomPositionY = arc4random_uniform(UInt32((scene?.size.height)! / 2)) + UInt32((scene?.size.height)! / 4)
        
        for r in 0...row - 1 {
            for c in 0...column - 1 {
                
                let coin = Coin()
                
                coin.size = CGSize(width: (scene?.size.height)! * 0.06, height: (scene?.size.height)! * 0.06)
                coin.position.x = sceneWidth! + (coin.size.width + spaceBetweenCoins) * CGFloat(c)
                coin.position.y = CGFloat(randomPositionY) + (coin.size.height + spaceBetweenCoins) * CGFloat(r)
                coin.setPhysicsBody()
                coinVector.append(coin)
            }
        }
        for coin in coinVector {
            scene?.addChild(coin)
            coin.startAnimation()
        }
        
        patternVector.append(coinVector)
    }
    
    func manageCoins(speed: CGFloat){
        
        for pattern in patternVector {
            
            for coin in pattern{
                
                coin.position.x -= speed
                if coin.position.x + coin.size.width / 2 <= 0 {
                    coin.removeFromParent()
                }
            }
        }
    }
}
