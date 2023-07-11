//
//  File.swift
//  
//
//  Created by David Crooks on 11/07/2023.
//

import Foundation

public protocol Triangulable {
    func triangulate() -> [Triangle]
}

extension Triangulable {
    public var area:Double {
        triangulate().map{ $0.area}.reduce(0,+)
    }
    
    public func containsPoint(_ p:SIMD2<Double>) -> Bool {
        triangulate().contains {
            $0.contains(point: p)
        }
    }
}



