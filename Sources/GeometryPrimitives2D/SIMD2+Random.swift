//
//  File.swift
//  
//
//  Created by David Crooks on 19/06/2021.
//

import Foundation

extension SIMD2 where Scalar == Double {
    public static func gaussian() ->SIMD2<Scalar> {
        //Box-Muller transform
        //https://en.wikipedia.org/wiki/Box%E2%80%93Muller_transform
        let u = Double.random(in: 0..<1)
        let v = Double.random(in: 0..<1)
        
        let r = sqrt(-2.0*log(u))
        let theta = 2*Double.pi*v
        
        return SIMD2<Scalar>( r*cos(theta),  r*sin(theta))
    }
}
