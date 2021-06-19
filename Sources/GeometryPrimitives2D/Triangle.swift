//
//  Triangle.swift
//  Quiddity
//
//  Created by David Crooks on 17/01/2019.
//  Copyright © 2019 David Crooks. All rights reserved.
//

import Foundation

public struct Triangle {
    
    public let a:SIMD2<Double>
    public var b:SIMD2<Double>
    public var c:SIMD2<Double>
    
    public init(A:SIMD2<Double>,B:SIMD2<Double>,C:SIMD2<Double>) {
        a = A
        b = B
        c = C
    }
    
    public var area:Double {
        return  abs(0.5*( a.x*(b.y - c.y) + b.x*(c.y - a.y) + c.x*(a.y - b.y) ))
    }
    
    public var perimeter:Double {
        let ab = b - a
        let bc = c - b
        let ca = a - c
        return ab.length + bc.length + ca.length
    }
    
    //Edges
    public var ab:LineSegment {
        return LineSegment(start: a, end: b)
    }
    
    public var bc:LineSegment {
        return LineSegment(start: b, end: c)
    }
    
    public var ca:LineSegment {
        return LineSegment(start: c, end: a)
    }
    
}

extension Triangle {
    
    public func contains(point p:SIMD2<Double>) ->Bool {
        //Compute vectors
        let v0 = c - a
        let v1 = b - a
        let v2 = p - a
        
        // Compute dot products
        let dot00 = v0•v0
        let dot01 = v0•v1
        let dot02 = v0•v2
        let dot11 = v1•v1
        let dot12 = v1•v2
        
        // Compute barycentric coordinates
        let  invDenom = 1.0 / (dot00 * dot11 - dot01 * dot01)
        let  u = (dot11 * dot02 - dot01 * dot12) * invDenom
        let  v = (dot00 * dot12 - dot01 * dot02) * invDenom
        
        // Check if point is in triangle
        return (u >= 0) && (v >= 0) && (u + v <= 1)
    }
    
    
    var circumcenter:SIMD2<Double>? {
      
        let p = Line(origin: ab.midPoint, direction: ab.vector.orthogonal)
        let q = Line(origin: bc.midPoint, direction: bc.vector.orthogonal)
        
        return q.intersect(with: p)
    }
    
}

extension Triangle:CustomStringConvertible  {
    public var description: String { get { return "Triangle A:\(a) B:\(b) C:(\(c) " } }
}



