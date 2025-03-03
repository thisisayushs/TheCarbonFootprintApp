//
//  DarkSecondBackground.swift
//  TheCarbonFootprintApp
//
//  Created by Ayush Kumar Singh on 02/03/25.
//

import SwiftUI

struct DarkSecondBackground: View {
    var body: some View {
        RadialGradient(
                    gradient: Gradient(colors: [Color.blue.opacity(0.6), Color.blue.opacity(0.2)]),
                    center: .center,
                    startRadius: 20,
                    endRadius: 400
                        
                )
                .ignoresSafeArea()
    }
}

#Preview {
    DarkSecondBackground()
}
