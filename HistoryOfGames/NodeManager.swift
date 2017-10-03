//
//  BackgroundManager.swift
//  HistoryOfGames
//
//  Created by Pedro Velmovitsky on 03/10/17.
//  Copyright © 2017 adabestgroup. All rights reserved.
//

import Foundation
import SpriteKit

let nodeManager = NodeManager()

class NodeManager{
    
    class var sharedInstance: NodeManager{
        return nodeManager
    }
    
    var backgroundNodes: [SKSpriteNode] = []
    var backgroundNodesPatternVector: [[SKSpriteNode]] = [[]]
    var floorBackgroundNodes: [String] = []
    var skyBackgroundNodes: [String] = []
    
    var scene: SKScene?
    var floor: Floor?
    
    
    
    func createBackgroundNodes(epochId: Int, scene: SKScene, floor: Floor) {
        
        backgroundNodes = []
        self.scene = scene
        self.floor = floor
        
        
        switch (epochId) {
            case 2:
                floorBackgroundNodes = ["tree1", "tree2", "tree3", "tree4", "tree5", "tree6", "tree7", "tree8", "tree9", "tree10"]
                skyBackgroundNodes = ["cloud1", "cloud2", "cloud3", "cloud4"]
                setBackgroundNodes()
            default:
                break

                    }
    }
    
    
    func setBackgroundNodes() {
        
        var backgroundNodes: [SKSpriteNode] = []
        
        let nodeKind = Int(arc4random_uniform(UInt32(2)))
        
        if (nodeKind == 0) {
 
            let column = Int(arc4random_uniform(UInt32(3))) + 1
            for c in 0...column - 1 {
                let nodeType = Int(arc4random_uniform(UInt32(floorBackgroundNodes.count)))
                let node = SKSpriteNode(imageNamed: floorBackgroundNodes[nodeType])
                node.size = CGSize(width: (scene?.size.height)! * 0.3, height: (scene?.size.height)! * 0.6)
                node.position.x = 1.1 * (scene?.size.width)! + (node.size.width) * CGFloat(c) 
                node.position.y = (floor?.size.height)! + node.size.height / 2 - 10
                node.zPosition = -1
                backgroundNodes.append(node)
            }
    }
        else {
            
            let nodeType = Int(arc4random_uniform(UInt32(skyBackgroundNodes.count)))
            let node = SKSpriteNode(imageNamed: skyBackgroundNodes[nodeType])
            node.size = CGSize(width: (scene?.size.height)! * 0.3, height: (scene?.size.height)! * 0.2)
            node.position.x = 1.1 * (scene?.size.width)! + (node.size.width)
            node.position.y = CGFloat(arc4random_uniform(UInt32(scene!.size.height * 0.3))) + (scene?.size.height)! * 0.7 - node.size.height / 2
            node.zPosition = -1
            backgroundNodes.append(node)
            
            
        }
        
        for node in backgroundNodes {
            scene?.addChild(node)
        }
        backgroundNodesPatternVector.append(backgroundNodes)
    }
}
