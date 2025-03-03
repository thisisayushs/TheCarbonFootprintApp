//
//  SecondOptionView.swift
//  TheCarbonFootprintApp
//
//  Created by Ayush Kumar Singh on 02/03/25.
//

import SwiftUI

struct SecondOptionView: View {
    var content: String = ""
    var icon: String = ""
    var body: some View {
        ZStack {
            
            RoundedRectangle(cornerRadius: 40, style: .continuous)
                .foregroundStyle(.white)
                .shadow(radius: 5)
                .frame(width: 360, height: 60)
            
            HStack {
                
                Image(systemName: icon)
                
                Text(content)
                    
            }.foregroundStyle(.black.opacity(0.8))
                .fontWeight(.semibold)
                .fontDesign(.rounded)
        }
    }
}

#Preview {
    SecondOptionView()
}
