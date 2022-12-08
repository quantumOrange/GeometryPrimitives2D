//
//  File.swift
//  
//
//  Created by David Crooks on 18/06/2021.
//

import Foundation


func cross2d<A:FloatingPoint>(_ p:SIMD2<A>,_ q:SIMD2<A>) -> A {
    //CHECK SIGN!
    return p.x * q.y - p.y * q.x
}


infix operator •

public func •(_ left: SIMD2<Double>, right:SIMD2<Double>) -> Double {
    return  left.x*right.x +  left.y*right.y
}


public extension SIMD2 where Scalar == Double {
    
    init(r:Double,theta θ:Double) {
        self.init(r * cos(θ),r * sin(θ))
    }
    
    static var zero:SIMD2<Double> {
        return SIMD2<Double>(0.0,0.0)
    }
    
    func distanceTo(_ p: SIMD2<Double>) -> Double{
        let q = self
        return  (q-p).length
    }
    
    func dot(_ q:SIMD2<Double>) -> Double {
        let p = self
        return p.x * q.x + p.y * q.y
    }
    
    /*
    func cross(_ q:SIMD2<Double>) -> Double {
        GeometryPrimitives2D.cross(self,q)
    }
    */
    func angle(_ q:SIMD2<Double>) -> Double {
        let c = self.dot(q) / (self.length    * q.length)
        return acos(c)
    }
    
    
    //The range of the angle is -π to π; an angle of 0 points to the right.
    var angle: Double {
        return atan2(y, x)
    }

    var length:Double {
        return sqrt(x*x + y*y)
    }
    
    var normalized:SIMD2<Double> {
        let l = length
        return SIMD2<Double>(x: x/l, y: y/l)
    }
    
    var lengthSquared:Double {
        return x*x + y*y
    }
    
    var isValid:Bool {
        if self.x.isNaN || self.y.isNaN {
            return false
        }
        return true
    }
    
    var orthogonal:SIMD2<Double> {
        return SIMD2<Double>(x: -y, y: x)
    }
}

func relativeAngle(_ u:SIMD2<Double>, _ v:SIMD2<Double>) -> Double {
    //angle of v relative to u
    var theta = atan2(v.y,v.x) - atan2(u.y,u.x)
    
    if theta < -Double.pi  {
        theta += 2*Double.pi
    }

    if theta > Double.pi {
        theta -= 2*Double.pi
    }
    
    return theta
}


