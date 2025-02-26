//
//  CardView.swift
//  TheCarbonFootprintApp
//
//  Created by Ayush Kumar Singh on 26/02/25.
//

import SwiftUI

struct CardView: View {
    var title: String
    var description: String
    var icon: String
    
    // Add initializer with default values matching original design
    init(title: String = "5.5 lbs CO₂/day", description: String = "Biking just twice a week could reduce your emissions, equivalent to planting 10 trees.", icon: String = "car") {
        self.title = title
        self.description = description
        self.icon = icon
    }
    
    var body: some View {
        VStack() {
            HStack {
                Image(systemName: icon)
                Text(title)
                   
                    
            } .foregroundStyle(.white)
                .font(.title)
                .fontDesign(.rounded)
                .fontWeight(.bold)
                
            
            Text(description)
                .foregroundStyle(.white)
                .font(.body)
                .padding(.top, 1)
            
        }
        .padding()
        .background {
            TransparentBlurView(removeAllFilters: true)
                .blur(radius: 9, opaque: true)
                .background(.white.opacity(0.05))
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                    .frame(width: 360, height: 150)
        }.padding()
    }
}

#Preview {
    CardView()
}
