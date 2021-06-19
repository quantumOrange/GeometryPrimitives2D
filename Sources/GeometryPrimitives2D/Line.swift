//
//  Ray.swift
//  Quiddity
//
//  Created by David Crooks on 18/01/2019.
//  Copyright © 2019 David Crooks. All rights reserved.
//

import Foundation


public struct Line {
    public let origin:SIMD2<Double>
    public let direction:SIMD2<Double>
    
    public init(origin:SIMD2<Double>,direction:SIMD2<Double>) {
        self.direction = direction.normalized
        self.origin = origin
    }
    
    public init(lineSegment line:LineSegment) {
        self.direction = line.vector.normalized
        self.origin = line.start
    }
}

extension Line {
    
    public func intersect(with line:Line) -> SIMD2<Double>? {
        
        var intersectionPoint:SIMD2<Double>?
        
        let denominator = cross(self.direction, line.direction)
        
        if denominator  != 0 {
            
            let a = line.origin - self.origin
            
            let t = cross(a,line.direction)/denominator
            
            intersectionPoint = self.evaluate(at:t)
        }
        
        return intersectionPoint
        
    }
    
    func intersect(with line:LineSegment) -> SIMD2<Double>? {
        
        var intersectionPoint:SIMD2<Double>?
        
        let denominator = cross(self.direction,line.vector)
        
        if denominator  != 0 {
            let t = cross(line.start - self.origin,line.vector)/denominator
            let u = cross(line.start - self.origin,self.direction)/denominator
            if (u > 0.0 && u < 1.0){
                intersectionPoint = self.evaluate(at:t)
            }
        }
        
        return intersectionPoint
    }
}
