//
//  SwiftUIView.swift
//  
//
//  Created by David Crooks on 17/07/2023.
//

import SwiftUI
import GeometryPrimitives2D
@available(iOS 13.0.0, *)
struct GeoView: View {
    var body: some View {
        GeometricShape(primitive: GeometryPrimitives2D.Circle(center: .zero, radius: 1))
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    @available(iOS 13.0.0, *)
    static var previews: some View {
        GeoView()
    }
}
