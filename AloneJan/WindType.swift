//
//  Wind.swift
//  AloneJan
//
//  Created by 田村 優吉 on 2016/06/23.
//  Copyright © 2016年 田村 優吉. All rights reserved.
//

import Foundation

enum WindType: Int, CustomStringConvertible {
    
    case East = 1
    case South
    case West
    case North
    
    var description: String {
        switch self {
        case .East:
            return "東"
        case .South:
            return "南"
        case .West:
            return "西"
        case .North:
            return "北"
        }
    }
    
}