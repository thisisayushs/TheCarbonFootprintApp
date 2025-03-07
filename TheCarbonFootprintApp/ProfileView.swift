//
//  ProfileView.swift
//  TheCarbonFootprintApp
//
//  Created by Ayush Kumar Singh on 27/02/25.
//

import SwiftUI

struct ProfileView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            ZStack {
                BackroundView(opacity: 0.5)
                    
                
                VStack(spacing: 30) {
            
                    
                    ZStack {
                        CircularProgressView(progress: 0.8)
                            .frame(width: 100, height: 100)
                        
                        Image("Memoji")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                            .clipShape(Circle())
                            .accessibilityLabel(Text("Profile"))

                    }
                   
                    HStack(spacing: 55) {
                        DataCard()
                        DataCard()
                    }
                    
                    VStack(spacing: 15) {
                        ProfileListItem(icon: "person", text: "Account Settings")
                        ProfileListItem(icon: "leaf", text: "My Impact Goals")
                        ProfileListItem(icon: "chart.dots.scatter", text: "Progress History")
                        ProfileListItem(icon: "bell", text: "Notifications")
                        ProfileListItem(icon: "gear", text: "Settings")
                    }
                    .foregroundStyle(.white)
                    .padding()
                }
            }
            
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Close") {
                        dismiss()
                    }
                    .foregroundStyle(.white)
                }
            }
        }
    }
}

struct ProfileListItem: View {
    var icon: String
    var text: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundStyle(.white)
                .font(.title2)
            
            Text(text)
                .font(.body)
                .fontWeight(.medium)
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundStyle(.gray)
        }
        .padding()
        .background {
            TransparentBlurView(removeAllFilters: true)
                .blur(radius: 9, opaque: true)
                .background(.white.opacity(0.05))
                .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
        }
        .frame(height: 60)
    }
}

#Preview {
    ProfileView()
}
