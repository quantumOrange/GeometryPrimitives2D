//
//  Circle.swift
//  DrawingDemoApp
//
//  Created by David Crooks on 28/02/2017.
//  Copyright © 2017 David Crooks. All rights reserved.
//

import Foundation
import simd

public struct Circle  {
    
    public let center: SIMD2<Double>
    public let radius: Double
    
    public init(center c:SIMD2<Double>,radius r:Double){
        center = c
        radius = r
    }
    
    public init(center c:SIMD2<Double>, point:SIMD2<Double>){
        self.center = c
        self.radius = (point - center).length
    }
    
    public init?(triangle:Triangle) {
        guard let circumcenter = triangle.circumcenter else { return nil }
        let v = circumcenter - triangle.a
        self.center = circumcenter
        self.radius = v.length
    }
    
    public init(line:LineSegment) {
        self.center = line.start
        self.radius = line.vector.length
    }
    
}

extension Circle {
    public var circumferance:Double {
        return 2 * .pi * radius
    }
    
    public var diameter:Double {
        return 2  * radius
    }
    
    public var area:Double {
        return .pi * radius * radius
    }
    
    public func invert( p:SIMD2<Double>) -> SIMD2<Double>{
         ((p - center) * radius * radius)/(length(p - center) * length(p - center) ) + center
    }
    
    public func contains( p:SIMD2<Double>) -> Bool {
       distance(center,p) < radius;
    }
    
    
}


extension Circle {
    public func intersect(with c:Circle) -> [SIMD2<Double>] {
        intersectCircles(self,c)
    }
    
    public func intersect(with l:Line) -> [SIMD2<Double>] {
        intersectLineCircle(self,l)
    }
    
    public func tangent(at θ:Double) -> Line {
        let r = SIMD2(x: radius * cos(θ),y: radius * sin(θ))
        let p = center + r
        
        let n = r.orthogonal
        
        return Line(origin: p, direction: n)
    }
    
    
    public func tangent(atCirclePoint p:SIMD2<Double>) -> Line {
        tangent(at:(p - center).angle)
    }
    
}


public func intersectLineCircle(_ c:Circle, _ l:Line) -> [SIMD2<Double>] {
//https://mathworld.wolfram.com/Circle-LineIntersection.html#:~:text=In%20geometry%2C%20a%20line%20meeting,secant%20line%20(Rhoad%20et%20al.
    let d = l.direction
    let p1 = l.origin - c.center
    let p2 = l.origin - c.center + d
    
    let D = p1.x * p2.y - p2.x * p1.y
    
    let dr = l.direction.length
    let r = c.radius
    let Δ = r * r * dr * dr - D * D
    
    if Δ < 0 {
        return []
    }
    
    let s:Double = d.y < 0 ? -1 : 1
    
    let x1 = D * d.y + s * d.x * Δ
    let y1 = -D * d.x + abs(d.y) * Δ
    
    
    let q1 = SIMD2(x: x1, y: y1) + c.center
    
    if Δ == 0 {
        return [q1]
    }
    
    let x2 = D * d.y - s * d.x * Δ
    let y2 = -D * d.x - abs(d.y) * Δ
    
    let q2 = SIMD2(x: x2, y: y2) + c.center
    
    return [q1,q2]
}

public func intersectCircles(_ c1:Circle, _ c2:Circle) -> [SIMD2<Double>] {
    //http://mathworld.wolfram.com/Circle-CircleIntersection.html
    let d = c1.center.distanceTo(c2.center)
    
    let r1_sq = c1.radius*c1.radius
    let r2_sq = c2.radius*c2.radius
    let x = ( d*d + r1_sq - r2_sq ) / ( 2*d )
    
    let d_sq = d*d
    let mm = d*d - r2_sq + r1_sq
    let y_sq = ( 4*d_sq * r1_sq - mm * mm ) / ( 4*d_sq )
    
    let v_x = (c2.center - c1.center).normalized
    let v_y = v_x.orthogonal
    
    let accuracy = 0.0001
    if (y_sq>accuracy){
        let y = sqrt(y_sq)

        let v_plus = x * v_x + y * v_y
        let v_minus = x * v_x - y * v_y
        
        return [ c1.center + v_plus, c1.center + v_minus ]
    }
    else if ( y_sq < accuracy &&  y_sq > -accuracy )
    {
        return [ c1.center +  x * v_x ]
    }
    else {
        return []
    }
}

extension Circle:Triangulable {
    public func triangulate() -> [Triangle] {
        return createPoints(360).adjacentPairs().map {
            Triangle(A: center, B: $0.0, C: $0.1)
        }
    }
}
