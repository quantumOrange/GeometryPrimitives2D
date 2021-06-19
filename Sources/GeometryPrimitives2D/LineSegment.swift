//
//  Line.swift
//  Quiddity
//
//  Created by David Crooks on 17/01/2019.
//  Copyright © 2019 David Crooks. All rights reserved.
//

import Foundation

public struct LineSegment {
    
    public let start:SIMD2<Double>
    public let end:SIMD2<Double>
    
    public init(start:SIMD2<Double>, end:SIMD2<Double>) {
        self.start = start
        self.end = end
    }
    
    public var vector:SIMD2<Double> {
        return end - start
    }

    public var length:Double {
        return vector.length
    }
    
    public var midPoint:SIMD2<Double> {
        return  start + 0.5*(end-start)
    }
    
    public var line:Line {
        return  Line(origin: start, direction: vector)
    }
}

extension LineSegment {
    
    func intersect(with line:LineSegment) -> SIMD2<Double>? {
        var intersectionPoint:SIMD2<Double>?
        
        let p = self
        let q = line
        
        let denominator = cross(p.vector,q.vector)
        if denominator  != 0 {
            let t = cross(q.start - p.start,q.vector)/denominator
            let u = cross(q.start - p.start,p.vector)/denominator
            if ((t > 0.0 && t < 1.0) &&  (u > 0.0 && u < 1.0)) {
                intersectionPoint = self.evaluate(at:t)
            }
        }
        return intersectionPoint
    }   
}

public func intersect(left:LineSegment, right:LineSegment) -> SIMD2<Double>? {
    return left.intersect(with: right)
}


