//
//  TheCarbonFootprintAppApp.swift
//  TheCarbonFootprintApp
//
//  Created by Ayush Kumar Singh on 25/02/25.
//

import SwiftUI

@main
struct TheCarbonFootprintAppApp: App {
    
    @AppStorage("isAnswered") var isAnswered: Bool = false
    
    var body: some Scene {
        WindowGroup {
            if isAnswered{
                HomeScreen()
                    .preferredColorScheme(.dark)
            }else{
                CarouselView()
            }
        }
    }
}
