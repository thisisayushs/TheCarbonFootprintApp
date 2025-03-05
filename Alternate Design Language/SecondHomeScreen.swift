//
//  SecondHomeScreen.swift
//  TheCarbonFootprintApp
//
//  Created by Ayush Kumar Singh on 02/03/25.
//



import SwiftUI
import SceneKit

struct SceneKitView: UIViewRepresentable {
    @Environment(\.colorScheme) var colorScheme
    func makeUIView(context: Context) -> SCNView {
        let sceneView = SCNView()
        guard let scene = SCNScene(named: "earth2.usdc") else { return sceneView }
        sceneView.scene = scene
        sceneView.allowsCameraControl = false  // Disable zoom
        sceneView.autoenablesDefaultLighting = true
        sceneView.backgroundColor = .clear

        if let modelNode = scene.rootNode.childNodes.first {
            modelNode.position = SCNVector3(0, -4.5, 0)
            rotateNode(modelNode) // Auto-rotation
            context.coordinator.modelNode = modelNode
        }

        // Add gesture recognizer for manual rotation
        let panGesture = UIPanGestureRecognizer(target: context.coordinator, action: #selector(context.coordinator.handlePan(_:)))
        sceneView.addGestureRecognizer(panGesture)

        return sceneView
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


struct SecondHomeScreen: View {
    @State private var currentPage = 0
    @State private var showProfile = false
    @Environment(\.colorScheme) var colorScheme
    @State private var shareImage: UIImage?
    @State private var isSharing = false
    @State private var isCapturing = false // Track screenshot state

    var body: some View {
        NavigationStack {
            ZStack {
                if colorScheme == .dark {
                    DarkSecondBackground()
                } else {
                    SecondBackgroundView()
                }

                TabView(selection: $currentPage) {
                    // First page
                    VStack(spacing: 20) {
                        Spacer()
                        VStack {
                            Text("Your carbon footprint score")
                                .padding(.top)
                                .foregroundStyle(.white)
                                .bold()
                                .font(.system(size: 20, design: .rounded))
                            Text("32.7")
                                .font(.system(size: 85, weight: .bold))
                                .foregroundStyle(.white)
                                .shadow(radius: 5)
                                .fontDesign(.rounded)
                        }

                        Spacer()
                        SceneKitView()
                            .shadow(radius: 5)
                            .frame(width: 350, height: 350)
                        Spacer()

                        if !isCapturing { // Hide share button when capturing
                            Button(action: {
                                captureAndShare()
                            }) {
                                SecondOptionView(content: "Share your world", icon: "square.and.arrow.up")
                            }
                            .tint(.white)
                            .padding(.bottom, 85)
                        }
                    }
                    .padding()
                    .tag(0)

                    // Second page
                    ScrollView {
                        VStack(spacing: 20) {
                            CardView(title: "5.5 lbs CO₂/day", description: "Biking just twice a week could reduce your emissions, equivalent to planting 10 trees.", icon: "bicycle")
                            CardView(title: "3.2 lbs CO₂/day", description: "Using public transport can significantly reduce your carbon footprint.", icon: "bus")
                            CardView(title: "2.8 lbs CO₂/day", description: "Walking short distances instead of driving helps protect our environment.", icon: "figure.walk")
                        }
                        .padding(.vertical)
                    }
                    .tag(1)
                }
                .tabViewStyle(.page)
                .indexViewStyle(isCapturing ? .page : .page(backgroundDisplayMode: .always)) // Hide indicators when capturing
            }
            .toolbar {
                if !isCapturing { // Hide toolbar when capturing
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: {
                            showProfile = false
                        }) {
                            Image("Memoji")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                                .clipShape(Circle())
                                .shadow(radius: 5)
                        }
                        .padding()
                    }
                }
            }
            .fullScreenCover(isPresented: $showProfile) {
                EmptyView()
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
}

// UIKit wrapper for Share Sheet
struct ShareSheet: UIViewControllerRepresentable {
    var activityItems: [Any]

    func makeUIViewController(context: Context) -> UIActivityViewController {
        UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}


#Preview {
    SecondHomeScreen()
}
