//
//  DataCard.swift
//  TheCarbonFootprintApp
//
//  Created by Ayush Kumar Singh on 27/02/25.
//

import SwiftUI

struct DataCard: View {
    var body: some View {
        
        
        VStack(alignment: .leading) {
            Text("32.7")
                .font(.title)
                .fontWeight(.bold)
                .fontDesign(.rounded)
            
            Text("Some sort of text")
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
                .frame(width: 175, height: 80)
            
        }
    }
}


#Preview {
    DataCard()
}
