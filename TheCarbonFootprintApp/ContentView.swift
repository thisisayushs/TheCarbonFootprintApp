//
//  ContentView.swift
//  TheCarbonFootprintApp
//
//  Created by Ayush Kumar Singh on 25/02/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            BackroundView()
            
            
            
            
            VStack {
                
                ProgressBar()
                
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
                        
                } .multilineTextAlignment(.center)
                   
                Spacer()
              
                
                VStack(spacing: 25) {
                    
                    
                    
                    Button(action: {
                        // Button action
                    }) {
                       OptionView(content: "I love walking")
                            
                    }
                    .padding()
                    
                    Button(action: {
                        // Button action
                    }) {
                        OptionView(content: "Public transport is my go to")
                    }.padding()
                    
                    Button(action: {
                        // Button action
                    }) {
                        OptionView(content: "I drive myself all the time")
                    }.padding()
                    
                    Button(action: {
                        // Button action
                    }) {
                        OptionView(content: "I usually share ride with others")
                    }.padding()
                        
                    
                }.tint(.white)
                
            }
                    
                    
                   
            }.padding()
            
            
            
            
            
            
    }
       
    }


#Preview {
    ContentView()
}
