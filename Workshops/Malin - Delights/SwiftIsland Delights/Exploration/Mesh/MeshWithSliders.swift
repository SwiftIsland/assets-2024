//
//  MeshWithSliders.swift
//  SwiftIsland Delights
//
//  Created by Malin Sundberg on 2024-08-24.
//

import SwiftUI

struct MeshWithSliders: View {
    @State private var centerPointX: Float = 0.5
    @State private var centerPointY: Float = 0.5
    
    var body: some View {
        let points: [SIMD2<Float>] = [
            [0.0, 0.0], [0.5, 0.0], [1.0, 0.0],
            [0.0, 0.5], [centerPointX, centerPointY], [1.0, 0.5],
            [0.0, 1.0], [0.5, 1.0], [1.0, 1.0]
        ]
        VStack {
            MeshGradient(width: 3,
                         height: 3,
                         points: points,
                         colors: [.pink, .pink, .orange,
                                  .indigo, .indigo, .indigo,
                                  .black, .black, .black
                         ],
                         background: .black,
                         smoothsColors: true)
        }
        .ignoresSafeArea()
        .overlay {
            MeshSlidersOverlay(centerPointX: $centerPointX, centerPointY: $centerPointY)
        }
    }
}

#Preview {
    MeshWithSliders()
}
