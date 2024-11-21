//
//  Settings.swift
//  Color Switch Clone
//
//  Created by Seedy on 12/11/2024.
//

import Foundation
import SpriteKit

enum PhysicsCategories{
    static let none: UInt32 = 0
    static let ballCategory: UInt32 = 0x1
    static let switchCategory: UInt32 = 0x1 << 1 // ????
}

// Z positions prioritizes which elements show on top or behind each other 
enum ZPositions{
    static let label: CGFloat = 0
    static let ball: CGFloat = 1
    static let colorSwitch: CGFloat = 2
}
