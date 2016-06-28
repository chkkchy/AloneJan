//
//  TileType.swift
//  AloneJan
//
//  Created by 田村 優吉 on 2016/06/22.
//  Copyright © 2016年 田村 優吉. All rights reserved.
//

import Foundation

enum TileType: Int, CustomStringConvertible {
    
    case Characters = 1
    case Circles
    case Bamboos
    case Honours
    
    static let allValues = [Characters, Circles, Bamboos, Honours]
    
    var description: String {
        switch self {
        case .Characters:
            return "萬子"
        case .Circles:
            return "筒子"
        case .Bamboos:
            return "索子"
        case .Honours:
            return "字牌"
        }
    }
    
}