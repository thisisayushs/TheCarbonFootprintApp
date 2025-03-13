//
//  DashboardView.swift
//  TheCarbonFootprintApp
//
//  Created by Trae AI on 06/03/25.
//

import SwiftUI

struct DashboardView: View {
    @AppStorage("carbonFootprintScore") var carbonFootprintScore: Double = 0.0
    @AppStorage("transportationScore") var transportationScore: Double = 0.0
    @AppStorage("foodScore") var foodScore: Double = 0.0
    @AppStorage("housingScore") var housingScore: Double = 0.0
    @AppStorage("energyScore") var energyScore: Double = 0.0
    @AppStorage("lifestyleScore") var lifestyleScore: Double = 0.0
    @AppStorage("waterScore") var waterScore: Double = 0.0
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Header
                Text("Category Breakdown")
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                    .foregroundStyle(.white)
                    .padding(.top, 20)
                


                
                // Category cards
                ForEach(QuestionCategory.allCases, id: \.self) { category in
                    CategoryScoreCard(
                        category: category,
                        score: scoreForCategory(category),
                        percentage: percentageForCategory(category)
                    )
                }
                
                // Tips section
                VStack(alignment: .leading, spacing: 15) {
                    Text("Improvement Tips")
                        .font(.headline)
                        .foregroundStyle(.white)
                    
                    ForEach(improvementTips(), id: \.self) { tip in
                        HStack(alignment: .top) {
                            Image(systemName: "leaf.fill")
                                .foregroundStyle(.green)
                                .font(.system(size: 16))
                                .frame(width: 24, height: 24)
                            
                            Text(tip)
                                .font(.subheadline)
                                .foregroundStyle(.white.opacity(0.9))
                                .fixedSize(horizontal: false, vertical: true)
                        }
                        .padding(.vertical, 5)
                    }
                }
                .padding()
                .background {
                    TransparentBlurView(removeAllFilters: true)
                        .blur(radius: 9, opaque: true)
                        .background(.white.opacity(0.05))
                        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                }
                .padding(.horizontal)
                .padding(.bottom, 30)
            }
        }
        
    }
    
    private func scoreForCategory(_ category: QuestionCategory) -> Double {
        switch category {
        case .transportation: return transportationScore
        case .food: return foodScore
        case .housing: return housingScore
        case .energy: return energyScore
        case .lifestyle: return lifestyleScore
        case .water: return waterScore
        }
    }
    
    private func percentageForCategory(_ category: QuestionCategory) -> Double {
        if carbonFootprintScore <= 0 { return 0 }
        return (scoreForCategory(category) / carbonFootprintScore) * 100
    }
    
    private func improvementTips() -> [String] {
        var tips: [String] = []
        
        if transportationScore > 100 {
            tips.append("Consider carpooling or using public transportation to reduce your transportation emissions.")
        }
        
        if foodScore > 50 {
            tips.append("Try incorporating more plant-based meals into your diet to reduce your food carbon footprint.")
        }
        
        if energyScore > 100 {
            tips.append("Switch to energy-efficient appliances and consider renewable energy sources for your home.")
        }
        
        if waterScore > 30 {
            tips.append("Install water-saving fixtures and take shorter showers to reduce water consumption.")
        }
        
        if lifestyleScore > 50 {
            tips.append("Practice mindful consumption by buying fewer new items and repairing what you already own.")
        }
        
        // Add general tips if we don't have enough specific ones
        if tips.count < 3 {
            tips.append("Unplug electronics when not in use to reduce phantom energy consumption.")
            tips.append("Use reusable bags, bottles, and containers to reduce single-use plastic waste.")
        }
        
        return Array(tips.prefix(4)) // Return at most 4 tips
    }
}

struct CategoryScoreCard: View {
    var category: QuestionCategory
    var score: Double
    var percentage: Double
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Image(systemName: category.icon)
                    .font(.title2)
                    .foregroundStyle(category.color)
                
                Text(category.rawValue)
                    .font(.headline)
                    .foregroundStyle(.white)
                
                Spacer()
                
                Text(String(format: "%.1f%%", percentage))
                    .font(.subheadline)
                    .foregroundStyle(.white.opacity(0.8))
            }
            
            HStack(spacing: 15) {
                Text(String(format: "%.2f", score))
                    .font(.system(size: 20, weight: .bold))
                    .foregroundStyle(category.color)
                
                ProgressBar(
                    width: 220,
                    height: 12,
                    percent: min(CGFloat(percentage), 100),
                    color1: category.color,
                    color2: category.color.opacity(0.5)
                )
            }
        }
        .padding()
        .background {
            TransparentBlurView(removeAllFilters: true)
                .blur(radius: 9, opaque: true)
                .background(.white.opacity(0.05))
                .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
        }
        .padding(.horizontal)
    }
}

#Preview {
    DashboardView()
        .preferredColorScheme(.dark)
}
