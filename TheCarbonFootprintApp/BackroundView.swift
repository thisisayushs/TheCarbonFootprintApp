//
//  BackroundView.swift
//  TheCarbonFootprintApp
//
//  Created by Ayush Kumar Singh on 25/02/25.
//

import SwiftUI

struct BackroundView: View {
    var body: some View {
        Image("Background")
            .resizable()
            .scaledToFit()
            .ignoresSafeArea()
            .blur(radius: 20)
            .scaleEffect(2.0)
    }
}

#Preview {
    BackroundView()
}
