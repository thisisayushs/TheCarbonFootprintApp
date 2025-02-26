//
//  ProgressBar.swift
//  TheCarbonFootprintApp
//
//  Created by Ayush Kumar Singh on 25/02/25.
//

import SwiftUI

struct ProgressBar: View {
    
    var width: CGFloat = 360
    var height: CGFloat = 20
    var percent: CGFloat = 50
    var color1: Color = Color(.green)
    var color2: Color = Color(.white.opacity(0.8))
    
    
    var body: some View {
        
        let multiplier = width / 100
        
        ZStack(alignment: .leading) {
            
           
            
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .frame(width: width, height: height)
                .foregroundStyle(Color.black.opacity(0.2))
            
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .frame(width: percent * multiplier, height: height)
                .background(
                    LinearGradient(gradient: Gradient(colors: [color1, color2]), startPoint: .leading, endPoint: .trailing))
                .clipShape( RoundedRectangle(cornerRadius: 20, style: .continuous))
                .foregroundStyle(.clear)
            
        }
    }
}

#Preview {
    ProgressBar()
}
