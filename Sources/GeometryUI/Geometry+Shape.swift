//
//  File.swift
//  
//
//  Created by David Crooks on 17/07/2023.
//

import Foundation
import GeometryPrimitives2D
import SwiftUI

@available(iOS 13.0, *)
public struct GeometricShape: Shape {
    public init(primitive:Drawable) {
        self.primitive = primitive
    }
    
    let primitive:Drawable
    
    public func path(in rect: CGRect) -> Path {
        return primitive.path.applying(transformClipSpaceToView(in:rect))
    }
}


public func transformClipSpaceToView(in rect:CGRect) -> CGAffineTransform {
    let dx = rect.midX
    let dy = rect.midY
    let scale = min(rect.width, rect.height) * 0.5

    return CGAffineTransform(translationX: dx, y: dy).scaledBy(x: scale, y: scale)
}
