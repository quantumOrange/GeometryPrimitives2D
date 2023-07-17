//
//  File.swift
//  
//
//  Created by David Crooks on 17/07/2023.
//

import Foundation
import SwiftUI
import GeometryPrimitives2D

@available(iOS 13.0, *)
public protocol Drawable {
    var path:Path {get}
}

extension Line : Drawable  {
    @available(iOS 13.0, *)
    public var path:Path {
        let rect = GeometryPrimitives2D.Rect(center:.zero,width:4,height:4)
        let points = intersect(with: rect)
        guard let first = points.first,let last = points.last else { return Path()}
        return LineSegment(start: first, end: last).path
    }
}

extension LineSegment : Drawable   {
    @available(iOS 13.0, *)
    public var path:Path {
        var path = Path()
        
        path.move(to: start.cgPoint)
        path.addLine(to: end.cgPoint)
        path.closeSubpath()
        
        return path
    }
}

extension GeometryPrimitives2D.Circle : Drawable   {
    @available(iOS 13.0, *)
    public var path:Path {
        var path = Path()
        path.addEllipse(in: CGRect(origin: center.cgPoint, size: CGSize(width: diameter, height: diameter)))
        return path
    }
}

extension Array<SIMD2<Double>> : Drawable {
    @available(iOS 13.0, *)
    public var path:Path {
        var path = Path()
        for p in self {
            
            path.addEllipse(in: CGRect(center: p.cgPoint, size: CGSize(width: 0.03, height: 0.03)))
        }
        return path
    }
}

extension CGRect {
    init(center:CGPoint,size:CGSize) {
        let x = center.x - 0.5 * size.width
        let y = center.y - 0.5 * size.height
        self.init(origin: CGPoint(x: x, y: y), size: size)
    }
}
