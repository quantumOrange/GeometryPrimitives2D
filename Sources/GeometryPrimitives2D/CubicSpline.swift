//
//  File.swift
//  
//
//  Created by David Crooks on 19/06/2021.
//

import Foundation

struct CubicSpline {
    let a:SIMD2<Double>
    let b:SIMD2<Double>
    let c:SIMD2<Double>
    let d:SIMD2<Double>

    private let α:Double
    private let β:Double
    private let γ:Double
    private let δ:Double
    
    init(a:SIMD2<Double>,b:SIMD2<Double>,c:SIMD2<Double>,d:SIMD2<Double>) {
        
        self.a = a
        self.b = b
        self.c = c
        self.d = d
        
        α = (-(a.y  *  b.x  *  (b.x - c.x)  *  c.x  *  (b.x - d.x)  *  (c.x - d.x) * d.x) +        a.x  *  (a.x - d.x)  *  d.x  *  (pow(b.x,2)  *  c.y  *  (b.x - d.x) +           b.y * pow(c.x,2) * (-c.x + d.x) +           a.x  *  (b.y  *  c.x * (c.x - d.x) + b.x * c.y * (-b.x + d.x))) +        a.x * (a.x - b.x) * b.x * (a.x - c.x) * (b.x - c.x) * c.x * d.y) /     ((a.x - b.x) * (a.x - c.x) * (b.x - c.x) * (a.x - d.x)  *  (b.x - d.x)   *         (c.x - d.x));
        
        β = (pow(a.x,2) *         (b.y * pow(c.x,2) * (-a.x + c.x) + (a.x - b.x) * pow(b.x,2) * c.y) +        (-(b.y * pow(c.x,3)) + pow(a.x,3) * (b.y - c.y) + pow(b.x,3) * c.y) *         pow(d.x,2) + (b.y * pow(c.x,2) - pow(b.x,2) * c.y +           pow(a.x,2) * (-b.y + c.y)) * pow(d.x,3) +        a.y * (b.x - c.x) * (b.x - d.x) * (c.x - d.x) *         (c.x * d.x + b.x * (c.x + d.x)) +        (-a.x + b.x) * (-a.x + c.x) * (-b.x + c.x) * (b.x * c.x + a.x * (b.x + c.x)) *         d.y) / ((a.x - b.x) * (a.x - c.x) * (b.x - c.x) * (a.x - d.x) * (b.x - d.x) *        (c.x - d.x));
        
        γ = (b.y * pow(c.x,3) * d.x - pow(b.x,3) * c.y * d.x -        b.y * c.x * pow(d.x,3) + b.x * c.y * pow(d.x,3) -        a.y * (b.x - c.x) * (b.x - d.x) * (c.x - d.x) * (b.x + c.x + d.x) +        pow(b.x,3) * c.x * d.y - b.x * pow(c.x,3) * d.y +        pow(a.x,3) * (b.y * c.x - b.x * c.y - b.y * d.x + c.y * d.x + b.x * d.y -           c.x * d.y) + a.x * (-(b.y * pow(c.x,3)) + b.y * pow(d.x,3) -           c.y * pow(d.x,3) + pow(b.x,3) * (c.y - d.y) + pow(c.x,3) * d.y)) /     ((a.x - b.x) * (a.x - c.x) * (b.x - c.x) * (a.x - d.x) * (b.x - d.x) *        (c.x - d.x));
        
        δ = (a.y * (b.x - c.x) * (b.x - d.x) * (c.x - d.x) +        (a.x - d.x) * (b.y * c.x * (c.x - d.x) + b.x * c.y * (-b.x + d.x) +           a.x * (c.y * (b.x - d.x) + b.y * (-c.x + d.x))) +        (-a.x + b.x) * (-a.x + c.x) * (-b.x + c.x) * d.y) /     ((a.x - b.x) * (a.x - c.x) * (b.x - c.x) * (a.x - d.x) * (b.x - d.x) *        (c.x - d.x));

    }

    func y(at x:Double) -> Double {
        α+β*x+γ*x*x + δ*x*x*x;
    }

    func derivative(x:Double) -> Double
    {
        β+2*γ*x + 3*δ*x*x;
    }

    func  secondDerivative(x:Double) -> Double
    {
        2*γ + 6*δ*x;
    }

}
