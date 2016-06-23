//
//  ArrayUtils.swift
//  AloneJan
//
//  Created by 田村 優吉 on 2016/06/22.
//  Copyright © 2016年 田村 優吉. All rights reserved.
//

import Foundation

class ArrayUtils {
    
    // destructive method
    static func shuffle<T>(inout array: [T]) {
        for i in 0..<array.count {
            let j = Int(arc4random_uniform(UInt32(array.count)))
            if i != j {
                swap(&array[i], &array[j])
            }
        }
    }
    
    // undestructive method
    static func shuffled<S: SequenceType>(source: S) -> [S.Generator.Element] {
        var copy = Array<S.Generator.Element>(source)
        shuffle(&copy)
        return copy
    }
    
}