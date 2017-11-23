//
//  Floor.swift
//  HistoryOfGames
//
//  Created by Pedro Velmovitsky on 31/08/17.
//  Copyright © 2017 adabestgroup. All rights reserved.
//

import UIKit
import SpriteKit

class Floor: SKSpriteNode {
    
    static var floorsArray: [Floor] = []
    static let maxFloors = 2
    static let imagesForEpochs = ["pongFloor", "pacmanFloor", "marioFloor", "marioFloor"]
    
    static var positionX:CGFloat {
        
        get {
            return floorsArray.first?.position.x ?? 0.0
        }
        
        set {
            for i in 0..<floorsArray.count {
                
                floorsArray[i].position.x =
                    i == 0 ? newValue
                           : floorsArray[i-1].position.x + floorsArray[i-1].size.width
            }
            
            if isOutOfScene {
                
                floorsArray.first!.position.x = floorsArray.last!.position.x + floorsArray.last!.size.width
                floorsArray.rearrange(from: 0, to: floorsArray.lastIndex)
                floorsArray.last!.texture = floorsArray.first!.texture
            }
        }
    }
    
    static var allImages: Int {
        get {
            return -1
        }
        
        set {
            print("Tamanho do array: \(floorsArray.count)")
            for i in 1..<floorsArray.count {
                floorsArray[i].setFloorImage(epochId: newValue)
            }
        }
    }
    
    static var isOutOfScene: Bool {
        
        if floorsArray.count == 0 { return false}
        return (floorsArray.first?.position.x)! < -((floorsArray.first?.size.width)! / 2)
    }
    
    init(epochId: Int, screenSize: CGSize) {
        
        let texture: SKTexture
        
        if(epochId == -1){
            
            texture = SKTexture(imageNamed: "transitionFloor")
        }
        else{
            
            texture = SKTexture(imageNamed: Floor.imagesForEpochs[epochId])
        }
        
        super.init(texture: texture, color: UIColor.clear, size: texture.size())
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    static func setFirstFloor(scene: SKScene){
        
        let floor = Floor(epochId: 0, screenSize: scene.size)
        
        // Width + 2 to compensate for the small space beetween floors.
        floor.size = CGSize(width: (scene.size.width) + 2, height: (scene.size.height) / 8)
        floor.position = CGPoint(x: (CGFloat(Floor.floorsArray.count) * (scene.size.width)),
                                 y: floor.size.height  / 2)
        print("Position y: ", floor.position.y)
        print("Scene size: ", scene.size)
        floor.setPhysicsBody()
        
        scene.addChild(floor)
        Floor.floorsArray.append(floor)
    }
    
    func setFloorImage(epochId: Int){
        
        if(epochId == -1){
            
            self.texture = SKTexture(imageNamed: "transitionFloor")
        }
        else{
            
            self.texture = SKTexture(imageNamed: Floor.imagesForEpochs[epochId])
        }
    }
    
    func setPhysicsBody() {
        self.physicsBody = SKPhysicsBody(rectangleOf: self.size)
        self.physicsBody?.isDynamic = false
        self.physicsBody?.categoryBitMask = PhysicsCategory.Floor
        self.physicsBody?.collisionBitMask = PhysicsCategory.Player
        self.physicsBody?.contactTestBitMask = PhysicsCategory.Player
    }


}
