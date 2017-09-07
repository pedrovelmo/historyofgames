//
//  PhysicsCategory.swift
//  WWDCGameTest
//
//  Created by Pedro Velmovitsky on 14/03/17.
//  Copyright © 2017 velmovitsky. All rights reserved.
//

import Foundation

// Types of objects in the game to configure collisions
public enum PhysicsCategory {
    static let None     : UInt32 = 0
    static let Player   : UInt32 = 0b010
    static let Obstacle : UInt32 = 0b011
    static let Floor    : UInt32 = 0b100

}
