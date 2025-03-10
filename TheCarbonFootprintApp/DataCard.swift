//
//  DataCard.swift
//  TheCarbonFootprintApp
//
//  Created by Ayush Kumar Singh on 27/02/25.
//

import SwiftUI

struct DataCard: View {
    @AppStorage("carbonFootprintScore") var carbonFootprintScore: Double = 0.0
    var body: some View {
        
        
        VStack(alignment: .leading) {
            Text(String(format: "%.2f", carbonFootprintScore))
                .font(.title)
                .fontWeight(.bold)
                .fontDesign(.rounded)
            
            Text("kg CO₂/month")
                .font(.caption)
                .fontWeight(.semibold)
                .fontDesign(.rounded)
        }.padding()
            .foregroundStyle(.white)
        .background {
            TransparentBlurView(removeAllFilters: true)
            
                .blur(radius: 9, opaque: true)
                .background(.white.opacity(0.05))
                .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                .frame(width: UIScreen.main.bounds.width, height: 80)
                .padding()

               
                
            
        }
    }
}


#Preview {
    DataCard()
}
