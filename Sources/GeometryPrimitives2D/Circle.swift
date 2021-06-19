//
//  Circle.swift
//  DrawingDemoApp
//
//  Created by David Crooks on 28/02/2017.
//  Copyright © 2017 David Crooks. All rights reserved.
//

import Foundation


public struct Circle  {
    
    public let center: SIMD2<Double>
    public let radius: Double
    
    public init(center c:SIMD2<Double>,radius r:Double){
        center = c
        radius = r
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
    
    public var area:Double {
        return .pi * radius * radius
    }
    
}


extension Circle {
    public func intersect(with c:Circle) -> [SIMD2<Double>] {
        return intersectCircles(self,c)
    }
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
