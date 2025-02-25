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
            
            SceneKitView()
                .frame(width: 500, height: 500)
                .padding()
        }
    }
}

#Preview {
    HomeScreen()
}
