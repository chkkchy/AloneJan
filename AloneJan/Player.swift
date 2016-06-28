//
//  Player.swift
//  AloneJan
//
//  Created by 田村 優吉 on 2016/06/23.
//  Copyright © 2016年 田村 優吉. All rights reserved.
//

import Foundation

class Player {
    
    var wind: WindType
    
    var point: Int
    
    var hand: [Tile]
    
    var disgarded: [Tile]
    
    var tsumo: Tile?
    
    init(wind: WindType, point: Int = 25000) {
        self.wind = wind
        self.point = point
        self.hand = []
        self.disgarded = []
    }
    
    func drawFrom(inout stack: [Tile], count: Int = 1) {
        for _ in 0 ..< count {
            tsumo = stack.removeLast()
            hand.append(tsumo!)
        }
    }
    
    func discardHand(index: Int) {
        self.disgarded.append(hand.removeAtIndex(index))
    }
    
    func sortHand() {
        hand.sortInPlace({(t1, t2) -> Bool in
            if t1.type.rawValue != t2.type.rawValue {
                return t1.type.rawValue < t2.type.rawValue
            }
            return t1.number < t2.number
        })
    }
    
}