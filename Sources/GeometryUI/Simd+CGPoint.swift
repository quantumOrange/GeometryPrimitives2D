//
//  File.swift
//  
//
//  Created by David Crooks on 17/07/2023.
//

import Foundation

extension SIMD2<Double> {
    var cgPoint:CGPoint {
        CGPoint(x: x, y: y)
    }
}
