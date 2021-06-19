//
//  Square.swift
//  Quiddity
//
//  Created by David Crooks on 21/01/2019.
//  Copyright © 2019 David Crooks. All rights reserved.
//

import Foundation

struct Square {
    let size:Double
    let center:SIMD2<Double>
    
    init(center:SIMD2<Double>, size:Double) {
        self.center = center
        self.size = size
    }
}
