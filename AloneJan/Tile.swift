//
//  Tile.swift
//  AloneJan
//
//  Created by 田村 優吉 on 2016/06/22.
//  Copyright © 2016年 田村 優吉. All rights reserved.
//

import Foundation

class Tile {
    
    var type: TileType
    
    var string: String
    
    var image: String
    
    var number: Int
    
    var isSuits: Bool {
        return self.type != TileType.Honours
    }
    
    init(type: TileType, string: String, image: String, number: Int) {
        self.type = type
        self.string = string
        self.image = image
        self.number = number
    }
    
}