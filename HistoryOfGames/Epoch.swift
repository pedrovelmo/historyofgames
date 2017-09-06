//
//  Epoch.swift
//  HistoryOfGames
//
//  Created by Pedro Velmovitsky on 31/08/17.
//  Copyright © 2017 adabestgroup. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit


class Epoch {
    
    var background : [Background]?
    var timeInEpoch: Timer?
    var floors: [Floor]?
    var whatEpochIsThis: Int?
    
    //TO-DO: Set timer when call init
    init(whatEpochIsThis: Int) {
        
        self.whatEpochIsThis = whatEpochIsThis
        
        switch whatEpochIsThis {
            
        case 0:
            
            background = [Background(epochId: whatEpochIsThis)]
            floors = [Floor(epochId: whatEpochIsThis)]

        default: break
            
        }
        
    }
    
}
