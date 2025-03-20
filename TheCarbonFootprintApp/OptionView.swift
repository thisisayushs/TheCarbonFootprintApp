//
//  OptionView.swift
//  TheCarbonFootprintApp
//
//  Created by Ayush Kumar Singh on 25/02/25.
//

import SwiftUI

struct OptionView: View {
    var content: LocalizedStringKey = "Option"
    var icon: String = ""
    var body: some View {
        ZStack {
            TransparentBlurView(removeAllFilters: true)
                .blur(radius: 9, opaque: true)
                .background(.white.opacity(0.05))
                .clipShape(.capsule)
                .frame(width: 360, height: 60)
                .background() {
                    Capsule()
                        .stroke(.white.opacity(0.3), lineWidth: 1.5)
                }
                .shadow(color: .black.opacity(0.2), radius: 10)
            
            HStack{
                Image(systemName: icon)
                
                Text(content)
            }
        }
                .fontWeight(.semibold)
                .fontDesign(.rounded)
              
        
    }
}

#Preview {
    OptionView()
}
