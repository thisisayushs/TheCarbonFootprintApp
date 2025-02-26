//
//  HomeScreen.swift
//  TheCarbonFootprintApp
//
//  Created by Ayush Kumar Singh on 25/02/25.
//

import SwiftUI
import SceneKit

struct SceneKitView: UIViewRepresentable {
    func makeUIView(context: Context) -> SCNView {
        let sceneView = SCNView()
        sceneView.scene = SCNScene(named: "Earth.usdz")
        sceneView.allowsCameraControl = true
        sceneView.autoenablesDefaultLighting = true
        sceneView.backgroundColor = .clear
        return sceneView
    }
    
    func updateUIView(_ uiView: SCNView, context: Context) {}
}

struct HomeScreen: View {
    var body: some View {
        ZStack {
            BackroundView()
            
            VStack {
                
                SceneKitView()
                    .frame(width: 400, height: 400)
                
                VStack() {
                    ScrollView {
                        CardView()
                        CardView(title: "1.8 tons CO₂/year", description: "Using fans and natural ventilation can cut energy use significantly!", icon: "house")
                        CardView(title: "1.2 tons CO₂/year", description: "A plant-based meal produces half the emissions of a meat-based one.", icon: "fork.knife")

                        CardView(title: "1300 lbs CO₂/year", description: "No new clothes for a month. Try it and see how much you can save", icon: "jacket")
                        CardView(title: "2.8 tons CO₂/year", description: "Taking a train instead of a short-haul flight can significantly lower your footprint", icon: "airplane")
                    }
                }
                    
            }
        }
    }
}

#Preview {
    HomeScreen()
}
