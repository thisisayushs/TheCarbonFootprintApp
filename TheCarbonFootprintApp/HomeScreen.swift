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
        sceneView.scene = SCNScene(named: "earth2.usdc")
        sceneView.allowsCameraControl = true
        sceneView.autoenablesDefaultLighting = true
        sceneView.backgroundColor = .clear
        return sceneView
    }
    
    func updateUIView(_ uiView: SCNView, context: Context) {}
}

struct HomeScreen: View {
    // Add state for current page
    @State private var currentPage = 0
    @State private var showProfile = false // Add state for profile sheet
    
    var body: some View {
        NavigationStack {
            ZStack {
                BackroundView()
                    .ignoresSafeArea()
                
                TabView(selection: $currentPage) {
                
                    // First page (existing content)
                    VStack(spacing: 20) {
                        Spacer()
                        
                        Text("Your carbon footprint score")
                            .padding(.top)
                            .foregroundStyle(.white)
                            .bold()
                            .font(.system(size: 20, design: .rounded))

                        Text("32.7")
                            .font(.system(size: 80, weight: .bold))
                            .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.green, .white.opacity(0.8)]), startPoint: .leading, endPoint: .trailing))
                            .fontDesign(.rounded)
                           
                          
                       


                        Spacer()

                        SceneKitView()
                            .frame(width: 400, height: 400)
                            .scaleEffect(1.3)
                        
                       


                        Spacer()

                        Button(action: {}) {
                            OptionView(content: "Share your world", icon: "square.and.arrow.up")
                        }.tint(.white)
                            
                            .padding(.bottom, 80)
                            
                        Spacer()
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
                .indexViewStyle(.page(backgroundDisplayMode: .always))
            }
         
            .toolbar {
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
                }
            }
            .fullScreenCover(isPresented: $showProfile) {
                ProfileView()
            }
        }
    }
}

#Preview {
    HomeScreen()
}
