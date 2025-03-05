//
//  HomeScreen.swift
//  TheCarbonFootprintApp
//
//  Created by Ayush Kumar Singh on 25/02/25.
//

import SwiftUI
import UIKit

struct HomeScreen: View {
    @State private var currentPage = 0
    @State private var showProfile = false
    @State private var isCapturing = false // Track screenshot state
    @State private var shareImage: UIImage?
    @State private var isSharing = false
    let textToShare = "Hello, world!"

    var body: some View {
        NavigationStack {
            ZStack {
                BackroundView()
                    .ignoresSafeArea()

                TabView(selection: $currentPage) {
                    VStack(spacing: 20) {
                        Spacer()

                        VStack {
                            Text("Your carbon footprint score")
                                .padding(.top)
                                .foregroundStyle(.white)
                                .bold()
                                .font(.system(size: 20, design: .rounded))

                            Text("32.7")
                                .font(.system(size: 80, weight: .bold))
                                .foregroundStyle(
                                    LinearGradient(gradient: Gradient(colors: [.green, .white.opacity(0.8)]), startPoint: .leading, endPoint: .trailing)
                                )
                                .fontDesign(.rounded)
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
                            showProfile = true
                        }) {
                            Image("Memoji")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                                .clipShape(Circle())
                        }
                        .padding()
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
}




#Preview {
    HomeScreen()
}

