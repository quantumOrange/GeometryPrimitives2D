//
//  Ray.swift
//  Quiddity
//
//  Created by David Crooks on 18/01/2019.
//  Copyright © 2019 David Crooks. All rights reserved.
//

import Foundation
import simd

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
    
    public func isLeft(p:SIMD2<Double>) -> Bool {
        //𝑑=(𝑥−𝑥1)(𝑦2−𝑦1)−(𝑦−𝑦1)(𝑥2−𝑥1)
        // check left right
        let u1 = origin
        let u2 = origin + direction
        
        let d = (p.x - u1.x) * ( u2.y - u1.y) - (p.y - u1.y) * ( u2.x - u1.x)
        
        return d > 0
    }
    
    public func lineSegmentIntersecting(with rect:Rect) -> LineSegment? {
        let points = intersect(with: rect)
        guard let first = points.first,let last = points.last else { return nil }
        return LineSegment(start: first, end: last)
    }
    
    public func lineSegmentIntersecting(with circle:Circle) -> LineSegment? {
        let points = intersect(with: circle)
        guard let first = points.first,let last = points.last else { return nil }
        return LineSegment(start: first, end: last)
    }
    
    public func intersect(with circle:Circle) -> [SIMD2<Double>] {
        intersectLineCircle(circle,self)
    }
    
    public func intersect(with ngon:any NGon) -> [SIMD2<Double>] {
        ngon.edges.compactMap{ edge in
            intersect(with: edge)
        }
    }
    
    public func intersect(with line:Line) -> SIMD2<Double>? {
        
        var intersectionPoint:SIMD2<Double>?
        
        let denominator = cross2d(self.direction, line.direction)
        
        if denominator  != 0 {
            
            let a = line.origin - self.origin
            
            let t = cross2d(a,line.direction)/denominator
            
            intersectionPoint = self.evaluate(at:t)
        }
        
        return intersectionPoint
        
    }
    
    public func intersect(with line:LineSegment) -> SIMD2<Double>? {
        
        var intersectionPoint:SIMD2<Double>?
        
        let denominator = cross2d(self.direction,line.vector)
        
        if denominator  != 0 {
            let t = cross2d(line.start - self.origin,line.vector)/denominator
            let u = cross2d(line.start - self.origin,self.direction)/denominator
            if (u > 0.0 && u < 1.0){
                intersectionPoint = self.evaluate(at:t)
            }
        }
        
        return intersectionPoint
    }
    
    public func reflect(p:SIMD2<Double>) -> SIMD2<Double> {
        let a = origin
        //projection of p-a onto the line
        let q = dot((p - a),direction) * direction
        
        // a + q is the closest point on the line
        // a + q - p is vector from p to closest point
        
        return 2*a + 2*q - p
    }
    
    public func distance(to p:SIMD2<Double>) -> Double {
        
        let a = origin
        //projection of p-a onto the line
        let q = dot((p - a),direction) * direction
        
        // a + q is the closest point on the line
        // a + q - p is vector from p to closest point
        
        // therfore the distance is
        
        return length(a + q - p)
        
    }
}

extension Line : Codable {
    
}
