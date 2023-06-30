//
//  Evaluable.swift
//  Quiddity
//
//  Created by David Crooks on 18/01/2019.
//  Copyright © 2019 David Crooks. All rights reserved.
//

import Foundation

public protocol Evaluable {
    func evaluate(at t:Double) -> SIMD2<Double>
    var  evaluableRange:Range<Double> { get }
    var  mininumEvaluable:Double { get }
    var  maximumEvaluable:Double { get }
}


extension Evaluable {
    public var  mininumEvaluable:Double { return  0.0 }
    public var  maximumEvaluable:Double { return  1.0 }
}

func  evaluate<E:Evaluable>(primitive e:E, at t:Double) -> SIMD2<Double> {
    return e.evaluate(at:t)
}

extension Evaluable {
    
    public func createPoints(_ n:Int) -> [SIMD2<Double>] {
       
        let dx = ( maximumEvaluable - mininumEvaluable ) / Double(n)
        
        return (0..<n)
                    .map { Double($0) * dx }
                    .map { evaluate(at: $0) }
        
        
    }
}
//Ambiguous reference to member 'min(by:)'

extension Circle: Evaluable {
    
    public var  mininumEvaluable:Double { return  0.0 }
    public var  maximumEvaluable:Double { return  2*Double.pi }
    
    public var  evaluableRange:Range<Double> {
        return 0..<2*Double.pi
    }
    
    public func evaluate(at t:Double) -> SIMD2<Double> {
        return center + radius*SIMD2<Double>(x:cos(t),y:sin(t))
    }
}

extension LineSegment: Evaluable {
    public var evaluableRange: Range<Double> {
        return 0.0..<1.0
    }
    
    public func evaluate(at t:Double) -> SIMD2<Double> {
        return start + t*vector
    }
}

extension Line: Evaluable {
    //TODO: fix ranges
    public  var evaluableRange: Range<Double> {
        return 0.0..<1.0
    }
    
    public func evaluate(at t:Double) -> SIMD2<Double> {
        return origin + t*direction
    }
}

extension NGon {
    public var  evaluableRange:Range<Double> {
        return 0..<2*Double.pi
    }
    
    public  func evaluate(at t:Double) -> SIMD2<Double> {
        let n = edges.count
        let p = t*Double(n)/Double.pi
        let index = Int( floor(p)) // 1234
        let frac = p.truncatingRemainder(dividingBy: 1) // 0.56789
        let line = edges[index]
        return line.evaluate(at:frac)
    }
}

extension Polygon:Evaluable {}
extension Triangle:Evaluable {}
extension Quad:Evaluable {}

