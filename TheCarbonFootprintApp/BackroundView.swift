//
//  BackroundView.swift
//  TheCarbonFootprintApp
//
//  Created by Ayush Kumar Singh on 25/02/25.
//

import SwiftUI

struct BackroundView: View {
    
    var opacity: Double = 0.0
    @AppStorage("carbonFootprintScore") var carbonFootprintScore: Double = 0.0

    
    var body: some View {
        RadialGradient(
                           gradient: Gradient(colors: [
                               getGradientColor().opacity(0.3),
                               getGradientColor().opacity(0.6),
                               
                           ]),
                           center: .center,
                           startRadius: 0,
                           endRadius: 1000
                       )
                       .ignoresSafeArea()
           
            
            
    }
    
    private func getGradientColor() -> Color {
            if carbonFootprintScore <= 916.2 {
                return .green
            } else if carbonFootprintScore <= 1733.3 {
                return .yellow
            } else {
                return .red
            }
        }
}

#Preview {
    BackroundView()
}
