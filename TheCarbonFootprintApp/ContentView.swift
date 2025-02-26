//
//  ContentView.swift
//  TheCarbonFootprintApp
//
//  Created by Ayush Kumar Singh on 25/02/25.
//

import SwiftUI
import UIKit

struct ContentView: View {
    // Add state to track current question
    @State private var currentQuestion = 0
    // Total number of questions
    let totalQuestions = 5
    // Add state to track if questionnaire is complete
    @State private var questionnaireComplete = false
    
    // Add haptic feedback generator
    let hapticImpact = UIImpactFeedbackGenerator(style: .medium)
    
    var body: some View {
        ZStack {
            BackroundView()
            
            // Show HomeScreen if questionnaire is complete, otherwise show the questionnaire
            if questionnaireComplete {
                HomeScreen()
                    .transition(.asymmetric(
                        insertion: .move(edge: .trailing).combined(with: .opacity),
                        removal: .move(edge: .leading).combined(with: .opacity)
                    ))
            } else {
                VStack {
                    // Update ProgressBar to show actual progress
                    ProgressBar(percent: CGFloat((currentQuestion * 100) / totalQuestions))
                    
                    Spacer()
                    
                    // Show the appropriate question based on currentQuestion state
                    if currentQuestion == 0 {
                        TransportationQuestion(goToNextQuestion: goToNextQuestion)
                    } else if currentQuestion == 1 {
                        DietQuestion(goToNextQuestion: goToNextQuestion)
                    } else if currentQuestion == 2 {
                        EnergyQuestion(goToNextQuestion: goToNextQuestion)
                    } else if currentQuestion == 3 {
                        ShoppingQuestion(goToNextQuestion: goToNextQuestion)
                    } else if currentQuestion == 4 {
                        RecyclingQuestion(goToNextQuestion: completeQuestionnaire)
                    }
                    
                    Spacer()
                }
                .padding()
                .transition(.asymmetric(
                    insertion: .move(edge: .leading).combined(with: .opacity),
                    removal: .move(edge: .trailing).combined(with: .opacity)
                ))
            }
        }
        // Add animation to the ZStack to animate between views
        .animation(.easeInOut(duration: 0.5), value: questionnaireComplete)
        .onAppear {
            // Prepare the haptic engine when view appears
            hapticImpact.prepare()
        }
    }
    
    // Function to advance to the next question with haptic feedback
    func goToNextQuestion() {
        // Trigger haptic feedback
        hapticImpact.impactOccurred()
        
        withAnimation {
            currentQuestion += 1
        }
    }
    
    // Function to complete the questionnaire and move to HomeScreen with haptic feedback
    func completeQuestionnaire() {
        // Trigger haptic feedback
        hapticImpact.impactOccurred()
        
        withAnimation {
            questionnaireComplete = true
        }
    }
}

// First question about transportation (existing content moved to its own view)
struct TransportationQuestion: View {
    var goToNextQuestion: () -> Void
    
    var body: some View {
        VStack {
            Spacer()
            
            VStack {
                Text("How do you get around?")
                    .foregroundStyle(.white)
                    .font(.title)
                    .fontDesign(.rounded)
                    .fontWeight(.bold)
                
                Text("From morning commutes to daily adventures, the way you move shapes the world.")
                    .fontWeight(.light)
                    .italic()
                    .foregroundStyle(.white)
                    .font(.body)
                    .padding(.top, 5)
                    
            }.multilineTextAlignment(.center)
            
            Spacer()
          
            VStack(spacing: 25) {
                Button(action: {
                    goToNextQuestion()
                }) {
                   OptionView(content: "I love walking")
                }
                .padding()
                
                Button(action: {
                    goToNextQuestion()
                }) {
                    OptionView(content: "Public transport is my go to")
                }.padding()
                
                Button(action: {
                    goToNextQuestion()
                }) {
                    OptionView(content: "I drive myself all the time")
                }.padding()
                
                Button(action: {
                    goToNextQuestion()
                }) {
                    OptionView(content: "I usually share ride with others")
                }.padding()
            }.tint(.white)
        }
    }
}

// Second question about diet habits
struct DietQuestion: View {
    var goToNextQuestion: () -> Void
    
    var body: some View {
        VStack {
            Spacer()
            
            VStack {
                Text("What best describes your diet?")
                    .foregroundStyle(.white)
                    .font(.title)
                    .fontDesign(.rounded)
                    .fontWeight(.bold)
                
                Text("Your food choices have a significant impact on carbon emissions from production to transportation.")
                    .fontWeight(.light)
                    .italic()
                    .foregroundStyle(.white)
                    .font(.body)
                    .padding(.top, 5)
                    
            }.multilineTextAlignment(.center)
            
            Spacer()
          
            VStack(spacing: 25) {
                Button(action: {
                    goToNextQuestion()
                }) {
                   OptionView(content: "Plant-based/Vegan")
                }
                .padding()
                
                Button(action: {
                    goToNextQuestion()
                }) {
                    OptionView(content: "Vegetarian")
                }.padding()
                
                Button(action: {
                    goToNextQuestion()
                }) {
                    OptionView(content: "Flexitarian (occasional meat)")
                }.padding()
                
                Button(action: {
                    goToNextQuestion()
                }) {
                    OptionView(content: "Regular meat consumption")
                }.padding()
            }.tint(.white)
        }
    }
}

// Third question about energy usage
struct EnergyQuestion: View {
    var goToNextQuestion: () -> Void
    
    var body: some View {
        VStack {
            Spacer()
            
            VStack {
                Text("How energy efficient is your home?")
                    .foregroundStyle(.white)
                    .font(.title)
                    .fontDesign(.rounded)
                    .fontWeight(.bold)
                
                Text("Home energy use contributes significantly to your carbon footprint.")
                    .fontWeight(.light)
                    .italic()
                    .foregroundStyle(.white)
                    .font(.body)
                    .padding(.top, 5)
                    
            }.multilineTextAlignment(.center)
            
            Spacer()
          
            VStack(spacing: 25) {
                Button(action: {
                    goToNextQuestion()
                }) {
                   OptionView(content: "Highly efficient (renewable energy)")
                }
                .padding()
                
                Button(action: {
                    goToNextQuestion()
                }) {
                    OptionView(content: "Moderately efficient")
                }.padding()
                
                Button(action: {
                    goToNextQuestion()
                }) {
                    OptionView(content: "Standard efficiency")
                }.padding()
                
                Button(action: {
                    goToNextQuestion()
                }) {
                    OptionView(content: "Not very efficient")
                }.padding()
            }.tint(.white)
        }
    }
}

// Fourth question about shopping habits
struct ShoppingQuestion: View {
    var goToNextQuestion: () -> Void
    
    var body: some View {
        VStack {
            Spacer()
            
            VStack {
                Text("How would you describe your shopping habits?")
                    .foregroundStyle(.white)
                    .font(.title)
                    .fontDesign(.rounded)
                    .fontWeight(.bold)
                
                Text("Consumer choices impact production, packaging, and shipping emissions.")
                    .fontWeight(.light)
                    .italic()
                    .foregroundStyle(.white)
                    .font(.body)
                    .padding(.top, 5)
                    
            }.multilineTextAlignment(.center)
            
            Spacer()
          
            VStack(spacing: 25) {
                Button(action: {
                    goToNextQuestion()
                }) {
                   OptionView(content: "Minimal, only essentials")
                }
                .padding()
                
                Button(action: {
                    goToNextQuestion()
                }) {
                    OptionView(content: "Moderate, secondhand when possible")
                }.padding()
                
                Button(action: {
                    goToNextQuestion()
                }) {
                    OptionView(content: "Regular shopping, some new items")
                }.padding()
                
                Button(action: {
                    goToNextQuestion()
                }) {
                    OptionView(content: "Frequent new purchases")
                }.padding()
            }.tint(.white)
        }
    }
}

// Fifth question about recycling habits
struct RecyclingQuestion: View {
    var goToNextQuestion: () -> Void
    
    var body: some View {
        VStack {
            Spacer()
            
            VStack {
                Text("How do you manage waste?")
                    .foregroundStyle(.white)
                    .font(.title)
                    .fontDesign(.rounded)
                    .fontWeight(.bold)
                
                Text("Waste management affects methane emissions and resource conservation.")
                    .fontWeight(.light)
                    .italic()
                    .foregroundStyle(.white)
                    .font(.body)
                    .padding(.top, 5)
                    
            }.multilineTextAlignment(.center)
            
            Spacer()
          
            VStack(spacing: 25) {
                Button(action: {
                    goToNextQuestion()
                }) {
                   OptionView(content: "Zero-waste lifestyle")
                }
                .padding()
                
                Button(action: {
                    goToNextQuestion()
                }) {
                    OptionView(content: "Comprehensive recycling")
                }.padding()
                
                Button(action: {
                    goToNextQuestion()
                }) {
                    OptionView(content: "Basic recycling")
                }.padding()
                
                Button(action: {
                    goToNextQuestion()
                }) {
                    OptionView(content: "Minimal recycling effort")
                }.padding()
            }.tint(.white)
        }
    }
}

#Preview {
    ContentView()
}
