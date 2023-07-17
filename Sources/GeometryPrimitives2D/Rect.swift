//
//  Rect.swift
//  Quiddity
//
//  Created by David Crooks on 21/01/2019.
//  Copyright © 2019 David Crooks. All rights reserved.
//

import Foundation

public struct Rect {
    public let width:Double
    public let height:Double
    public let center:SIMD2<Double>
    
    public init(center:SIMD2<Double>, width:Double,height:Double) {
        self.center = center
        self.width = width
        self.height = height
    }
    
    public init(origin:SIMD2<Double>, width:Double,height:Double) {
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
    var topLeft:SIMD2<Double> {
        center + [-0.5 * width,0.5 * height]
    }
    
    var topRight:SIMD2<Double> {
        center + [0.5 * width,0.5 * height]
    }
    
    var bottomLeft:SIMD2<Double> {
        center + [-0.5 * width,-0.5 * height]
    }
    
    var bottomRight:SIMD2<Double> {
        center + [0.5 * width,-0.5 * height]
    }
    
    // clockwise directed line segments
    var top:LineSegment {
        LineSegment(start: topLeft, end: topRight)
    }
    
    var bottom:LineSegment {
        LineSegment(start: bottomRight, end: bottomLeft)
    }
    
    var left:LineSegment {
        LineSegment(start: bottomLeft, end: bottomRight)
    }
    
    var right:LineSegment {
        LineSegment(start: topRight, end: bottomRight)
    }
    
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
    public func triangulate() -> [Triangle] {
        [Triangle(A: a, B: b, C: c),Triangle(A: b, B: c, C: d)]
    }
}
