//
//  ProfileView.swift
//  TheCarbonFootprintApp
//
//  Created by Ayush Kumar Singh on 27/02/25.
//

import SwiftUI

struct ProfileView: View {
    @Environment(\.dismiss) private var dismiss
    @AppStorage("carbonFootprintScore") var carbonFootprintScore: Double = 0.0
    @AppStorage("isAnswered") var isAnswered: Bool = false
    @State private var showingAlert = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                BackroundView(opacity: 0.5)
                
                VStack(spacing: 30) {
                    VStack(spacing: 15) {
                        Button {
                            showingAlert = true
                        } label: {
                            ProfileListItem(icon: "chart.dots.scatter", text: String(localized: "reset_questionnaire"))
                        }
                        .alert(String(localized: "reset_questionnaire"), isPresented: $showingAlert) {
                            Button(String(localized: "cancel"), role: .cancel) { }
                            Button(String(localized: "retake"), role: .destructive) {
                                carbonFootprintScore = 0.0
                                isAnswered = false
                                dismiss()
                            }
                        } message: {
                            Text(LocalizedStringKey("reset_confirmation"))
                        }

                        ProfileListItem(icon: "person", text: String(localized: "account_settings"))
                        ProfileListItem(icon: "leaf", text: String(localized: "impact_goals"))
                        ProfileListItem(icon: "bell", text: String(localized: "notifications"))
                        ProfileListItem(icon: "gear", text: String(localized: "settings"))
                    }
                    .foregroundStyle(.white)
                    .padding()
                }
            }
            
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(String(localized: "close")) {
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
