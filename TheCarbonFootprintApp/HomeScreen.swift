//
//  HomeScreen.swift
//  TheCarbonFootprintApp
//
//  Created by Ayush Kumar Singh on 25/02/25.
//

import SwiftUI
import UIKit
import SceneKit


struct SceneKitView: UIViewRepresentable {
    
    @Environment(\.colorScheme) var colorScheme
    @AppStorage("carbonFootprintScore") var carbonFootprintScore: Double = 2000

    func makeUIView(context: Context) -> SCNView {
        let sceneView = SCNView()
        guard let scene = SCNScene(named: getEarthModelName()) else { return sceneView }
        sceneView.scene = scene
        sceneView.allowsCameraControl = false  // Disable zoom
        sceneView.autoenablesDefaultLighting = true
        sceneView.backgroundColor = .clear

        if let modelNode = scene.rootNode.childNodes.first {
            
            if carbonFootprintScore <= 916.2 {
                modelNode.position = SCNVector3(0, -4.5, 0)
            } else if carbonFootprintScore <= 1733.3 {
                modelNode.position = SCNVector3(0, -1.7, 0)
            } else {
                modelNode.position = SCNVector3(0, -3.5, 0)
            }
            
            rotateNode(modelNode) // Auto-rotation
            context.coordinator.modelNode = modelNode
        }

        // Add gesture recognizer for manual rotation
        let panGesture = UIPanGestureRecognizer(target: context.coordinator, action: #selector(context.coordinator.handlePan(_:)))
        sceneView.addGestureRecognizer(panGesture)

        return sceneView
    }
    
    private func getEarthModelName() -> String {
            if carbonFootprintScore <= 916.2 {
                return "earth_Green.usdc"
            } else if carbonFootprintScore <= 1733.3 {
                return "earth_Yellow.usdc"
            } else {
                return "earth_Red.usdc"
            }
        }

    func updateUIView(_ uiView: SCNView, context: Context) {}

    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }

    // Function for automatic rotation
    private func rotateNode(_ node: SCNNode) {
        let rotation = SCNAction.rotateBy(x: 0, y: 0, z: 1, duration: 5)
        let repeatRotation = SCNAction.repeatForever(rotation)
        node.runAction(repeatRotation)
    }

    // Coordinator for gesture handling
    class Coordinator: NSObject {
        var modelNode: SCNNode?
        private var lastPanLocation: CGPoint?

        @objc func handlePan(_ gesture: UIPanGestureRecognizer) {
            guard let node = modelNode else { return }

            let translation = gesture.translation(in: gesture.view)
            
            let angleX = Float(translation.y) * 0.005
            let angleY = Float(translation.x) * 0.005
            
            // Creazione delle rotazioni su X e Y
            let xRotation = simd_quatf(angle: angleX, axis: SIMD3<Float>(1, 0, 0))
            let yRotation = simd_quatf(angle: angleY, axis: SIMD3<Float>(0, 1, 0))
            
            // Combiniamo le due rotazioni con la rotazione esistente
            let newRotation = simd_mul(node.simdOrientation, simd_mul(yRotation, xRotation))
            node.simdOrientation = newRotation

            gesture.setTranslation(.zero, in: gesture.view) // Reset del valore per la prossima iterazione
        }

    }
}

struct HomeScreen: View {
    @State private var currentPage = 0
    @State private var showProfile = false
    @State private var isCapturing = false // Track screenshot state
    @State private var shareImage: UIImage?
    @State private var isSharing = false
    @AppStorage("carbonFootprintScore") var carbonFootprintScore: Double = 0.0

    var body: some View {
        NavigationStack {
            ZStack {
                BackroundView()
                    .ignoresSafeArea()

                TabView(selection: $currentPage) {
                    VStack(spacing: 20) {

                        VStack {
                            Text("You are wasting")
                                .foregroundStyle(.white)
                                .bold()
                                .font(.system(size: 20, design: .rounded))
                                .padding(.top)

                            Text(String(format: "%.2f", carbonFootprintScore))
                                .font(.system(size: 80, weight: .bold))
                                .foregroundStyle(
                                    LinearGradient(gradient: Gradient(colors: [getScoreColor(), .white.opacity(0.8)]), startPoint: .leading, endPoint: .trailing)
                                )
                                .fontDesign(.rounded)
                                
                            
                            Text("kg CO₂/month")
                                .foregroundStyle(.white)
                                .bold()
                                .font(.system(size: 14, design: .rounded))
                        }

                        Spacer()

                        SceneKitView()
                            .frame(width: 350, height: 350)

                        Spacer()

                        if !isCapturing { // Hide share button when capturing
                            Button(action: {
                                captureAndShare()
                            }) {
                                OptionView(content: "Share your world", icon: "square.and.arrow.up")
                                    .foregroundStyle(.white)
                            }
                            .foregroundStyle(.white)
                        }

                        Button(action: {}) {}
                            .tint(.white)
                            .padding(.bottom, 85)
                    }
                    .padding()
                    .tag(0)

                  
                    
                    // Third tab - Dashboard
                    DashboardView()
                        .tag(1)
                }
                .tabViewStyle(.page)
                .indexViewStyle(isCapturing ? .page : .page(backgroundDisplayMode: .always)) // Hide indicators when capturing
            }

            .toolbar {
                if !isCapturing { // Hide toolbar when capturing
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: {
                            showProfile = true
                        }) {
                            Image(systemName: "gear")
                                .font(.headline)
                                .foregroundStyle(.white)
                                .padding(10)
                                .background {
                                    TransparentBlurView(removeAllFilters: true)
                                        .blur(radius: 5, opaque: true)
                                        .background(.white.opacity(0.1))
                                        .clipShape(Circle())
                                }
                        }
                    }
                }
            }
            .fullScreenCover(isPresented: $showProfile) {
                ProfileView()
            }
        }
        .sheet(isPresented: $isSharing) {
            if let image = shareImage {
                ShareSheet(activityItems: [image])
            }
        }
    }
    
    // Function to capture the screen as an image
    private func captureAndShare() {
        isCapturing = true // Hide UI elements before capture

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { // Small delay to update UI
            let controller = UIApplication.shared.connectedScenes
                .compactMap { $0 as? UIWindowScene }
                .flatMap { $0.windows }
                .first { $0.isKeyWindow }

            let renderer = UIGraphicsImageRenderer(size: controller?.bounds.size ?? .zero)
            let image = renderer.image { context in
                controller?.drawHierarchy(in: controller?.bounds ?? .zero, afterScreenUpdates: true)
            }

            self.shareImage = image
            self.isCapturing = false // Restore UI after capture
            self.isSharing = true
        }
    }
    
    // Funzione per determinare il colore in base al punteggio
    private func getScoreColor() -> Color {
        if carbonFootprintScore <= 916.2 {
            return .green
        } else if carbonFootprintScore <= 1733.3 {
            return .yellow
        } else {
            return .red
        }
    }
}

struct ShareSheet: UIViewControllerRepresentable {
    var activityItems: [Any]

    func makeUIViewController(context: Context) -> UIActivityViewController {
        UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}




#Preview {
    HomeScreen()
}

