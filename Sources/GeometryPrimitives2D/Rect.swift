//
//  Rect.swift
//  Quiddity
//
//  Created by David Crooks on 21/01/2019.
//  Copyright © 2019 David Crooks. All rights reserved.
//

import Foundation

struct Rect {
    let width:Double
    let height:Double
    let center:SIMD2<Double>
    
    init(center:SIMD2<Double>, width:Double,height:Double) {
        self.center = center
        self.width = width
        self.height = height
    }
    
    init(origin:SIMD2<Double>, width:Double,height:Double) {
        self.center =  origin + 0.5 * SIMD2<Double>(width,height)
        self.width = width
        self.height = height
    }
    
    var a:SIMD2<Double> {
        center + 0.5 * [ -width, height]
    }
    
    var b:SIMD2<Double> {
        center + 0.5 * [ -width, -height]
    }
    
    var c:SIMD2<Double> {
        center + 0.5 * [ width, height]
    }
    
    var d:SIMD2<Double> {
        center + 0.5 * [ width, -height]
    }
    
    
}

extension Rect {
    var area:Double {
        return width * height
    }
    
    var origin:SIMD2<Double> {
        center - 0.5 * SIMD2<Double>(width,height)
    }
    
    var quad:Quad {
        Quad(a: a, b: b, c: c, d: d)
    }
}

extension Rect:Triangulable {
    func triangulate() -> [Triangle] {
        [Triangle(A: a, B: b, C: c),Triangle(A: b, B: c, C: d)]
    }
}
