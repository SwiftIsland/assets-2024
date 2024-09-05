//
//  MeshSlidersOverlay.swift
//  SwiftIsland Delights
//
//  Created by Malin Sundberg on 2024-08-24.
//

import SwiftUI

struct MeshSlidersOverlay: View {
    @Binding var centerPointX: Float
    @Binding var centerPointY: Float
    
    var body: some View {
        VStack {
            Text("\(centerPointX.formatted(.number.precision(.fractionLength(2)))), \(centerPointY.formatted(.number.precision(.fractionLength(2))))")
                .font(.title2)
                .bold()
                .foregroundStyle(Material.regular)
            
            Spacer()
            
            Slider(value: $centerPointY, in: 0...1)
                .frame(height: 350)
                .rotationEffect(.degrees(-270))
                .offset(x: -350/2)
                .padding(.leading)
            
            Spacer()
            
            Slider(value: $centerPointX, in: 0...1)
                .frame(width: 350)
        }
        .padding()
    }
}

#Preview {
    MeshSlidersOverlay(centerPointX: .constant(0.5), centerPointY: .constant(0.5))
}
