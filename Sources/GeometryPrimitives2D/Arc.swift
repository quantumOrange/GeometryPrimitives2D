//
//  File.swift
//  
//
//  Created by David Crooks on 30/06/2023.
//

import Foundation

public struct Arc  {
    
    public let center: SIMD2<Double>
    public let radius: Double
    public let startAngle:Double
    public let endAngle:Double
    
    public var startPoint:SIMD2<Double> {
        evaluate(at: 0)
    }
    
    public var endPoint:SIMD2<Double> {
        evaluate(at: 1)
    }
    
    public init(center c:SIMD2<Double>,radius r:Double, startAngle:Double,endAngle:Double){
        center = c
        radius = r
        self.startAngle = startAngle
        self.endAngle = endAngle
    }
    
    public init(center c:SIMD2<Double>, point:SIMD2<Double>, arcangle:Double, centered:Bool = false){
        self.center = c
        let v = (point - center)
        self.radius = v.length
        let theta = v.angle
        /*
        if centered {
            self.startAngle = theta - 0.5 * arcangle
            self.endAngle =  theta + 0.5 * arcangle
        }
        else {
            self.startAngle = theta
            self.endAngle =  theta + arcangle
        }
         */
        self.startAngle = theta
        self.endAngle =  theta + arcangle
    }
    
    public var length:Double {
        abs(endAngle - startAngle) * radius
    }
    
    public func createPoints(_ n:Int) -> [SIMD2<Double>] {
       
        let dx = 1 / Double(n)
        
        return (0..<n)
                    .map { Double($0) * dx }
                    .map { evaluate(at: $0) }
        
        
    }
}

extension Arc : Evaluable  {
    public func evaluate(at t: Double) -> SIMD2<Double> {
        let theta =  startAngle  + t * ( endAngle - startAngle)
        return center + SIMD2(r: radius, theta: theta)
    }
    
    public var evaluableRange: Range<Double> {
        0..<1
    }
    
}

extension Arc:Triangulable {
    public func triangulate() -> [Triangle] {
        let arcAngle =  endAngle - startAngle
        let n = Int(arcAngle * 50.0)
        
        return createPoints(n).adjacentPairs().map {
            Triangle(A: center, B: $0.0, C: $0.1)
        }
    }
}
