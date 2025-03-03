//
//  SecondBackgroundView.swift
//  TheCarbonFootprintApp
//
//  Created by Ayush Kumar Singh on 02/03/25.
//

import SwiftUI

struct SecondBackgroundView: View {
    var body: some View {
        ZStack {
            
            Color.cyan
                .ignoresSafeArea()
            
                
               
                Color.white.opacity(0.8)
                    
                    .blur(radius: 200)
                
                
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            
                    .ignoresSafeArea()
                    
                    
            
            
        }
    }
}

#Preview {
    SecondBackgroundView()
}
