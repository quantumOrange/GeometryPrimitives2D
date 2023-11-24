//
//  File.swift
//  
//
//  Created by David Crooks on 21/06/2021.
//

import Foundation

extension Array where Element==SIMD2<Double> {
    var centroid:SIMD2<Double> {
        reduce(SIMD2<Double>.zero,+)/Double(count)
        //let x = map { $0.x }.reduce(0,+)/Double(count)
       // let y = map { $0.y }.reduce(0,+)/Double(count)
        //return SIMD2<Double>(x: x, y: y)
    }
}

extension Array {
    public func adjacentPairs() -> Zip2Sequence<[Element], Array<Element>.SubSequence> {
        zip(self,self.dropFirst())
    }
    
    public func cyclicAdjacentPairs() -> Zip2Sequence<[Element], [Element]> {
        guard let last = self.last else {return zip(self,self)}
        return zip([last] + self,self)
    }
}
