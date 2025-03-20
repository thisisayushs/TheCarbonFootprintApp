import SwiftUI

// Add category to Page struct
struct Page: Identifiable {
    let id = UUID()
    let number: Int
    let question: String
    let answers: [(String, Double)]
    let category: QuestionCategory
}

// Define question categories
enum QuestionCategory: String, CaseIterable {
    case transportation = "transportation"
    case food = "food"
    case housing = "housing"
    case energy = "energy"
    case lifestyle = "lifestyle"
    case water = "water"
    
    var icon: String {
        switch self {
        case .transportation: return "car.fill"
        case .food: return "fork.knife"
        case .housing: return "house.fill"
        case .energy: return "bolt.fill"
        case .lifestyle: return "bag.fill"
        case .water: return "drop.fill"
        }
    }
    
    var color: Color {
        switch self {
        case .transportation: return .blue
        case .food: return .green
        case .housing: return .orange
        case .energy: return .yellow
        case .lifestyle: return .purple
        case .water: return .cyan
        }
    }
}

struct CarouselCardView: View {
    let page: Page
    let currentIndex: Int
    let onAnswerSelected: (String) -> Void
    
    @State private var selectedAnswer: String? = nil
    
    var body: some View {
        ZStack {
            cardView(page)
        }
        .modifier(CarouselEffect(index: page.number - 1, currentIndex: currentIndex, translation: 0))
        // Disabilita l'interazione per le carte che non sono quella corrente
        .allowsHitTesting(page.number - 1 == currentIndex)
    }
    
    private func cardView(_ page: Page) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30)
                .fill(Material.ultraThinMaterial)
                .opacity(0.3)
                .frame(width: 300, height: 400)
                .overlay(
                    RoundedRectangle(cornerRadius: 30)
                        .stroke(Color.white.opacity(0.2), lineWidth: 0.5)
                        .blur(radius: 0.3)
                )
                .overlay(
                    VStack(spacing: 30) {
                        Text(page.question)
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(.white.opacity(0.9))
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 20)
                            .padding(.top, 30)
                        
                        VStack(spacing: 15) {
                            ForEach(page.answers, id: \.0) { answer, _ in
                                Button(action: {
                                    withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                                        selectedAnswer = answer
                                    }
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                                        onAnswerSelected(answer)
                                    }
                                }) {
                                    Text(answer)
                                        .font(.system(size: 16))
                                        .foregroundColor(selectedAnswer == answer ? .yellow : .white.opacity(0.8))
                                        .frame(maxWidth: .infinity)
                                        .padding(.vertical, 12)
                                        .background(
                                            RoundedRectangle(cornerRadius: 12)
                                                .fill(Material.ultraThinMaterial)
                                                .opacity(0.2)
                                        )
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 12)
                                                .stroke(Color.white.opacity(0.3), lineWidth: 0.5)
                                        )
                                        .scaleEffect(selectedAnswer == answer ? 1.1 : 1.0)
                                        .padding(.horizontal, 20)
                                }
                                .disabled(selectedAnswer != nil)
                            }
                        }
                        .padding(.bottom, 30)
                    }
                )
        }
    }
}

struct CarouselView: View {
    @AppStorage("isAnswered") var isAnswered: Bool = false
    @AppStorage("carbonFootprintScore") var carbonFootprintScore: Double = 0.0
    
    // Add category scores
    @AppStorage("transportationScore") var transportationScore: Double = 0.0
    @AppStorage("foodScore") var foodScore: Double = 0.0
    @AppStorage("housingScore") var housingScore: Double = 0.0
    @AppStorage("energyScore") var energyScore: Double = 0.0
    @AppStorage("lifestyleScore") var lifestyleScore: Double = 0.0
    @AppStorage("waterScore") var waterScore: Double = 0.0

    private let pages = [
        Page(number: 1, question: String(localized: "q1_transport"), answers: [
            (String(localized: "a1_never"), 0.0),
            (String(localized: "a1_occasionally"), 50.0),
            (String(localized: "a1_regularly"), 150.0),
            (String(localized: "a1_daily"), 300.0)
        ], category: .transportation),
        
        Page(number: 2, question: String(localized: "q2_diet"), answers: [
            (String(localized: "a2_vegan"), 10.0),
            (String(localized: "a2_vegetarian"), 30.0),
            (String(localized: "a2_limited_meat"), 80.0),
            (String(localized: "a2_high_meat"), 200.0)
        ], category: .food),
        
        Page(number: 3, question: String(localized: "q3_heating"), answers: [
            (String(localized: "a3_renewable"), 10.0),
            (String(localized: "a3_electricity"), 50.0),
            (String(localized: "a3_natural_gas"), 150.0),
            (String(localized: "a3_coal"), 300.0)
        ], category: .housing),
        
        Page(number: 4, question: String(localized: "q4_flying"), answers: [
            (String(localized: "a4_never"), 0.0),
            (String(localized: "a4_1_2_flights"), 42.0),
            (String(localized: "a4_3_5_flights"), 125.0),
            (String(localized: "a4_more_5_flights"), 417.0)
        ], category: .transportation),
        
        Page(number: 5, question: String(localized: "q5_home"), answers: [
            (String(localized: "a5_small"), 8.3),
            (String(localized: "a5_medium"), 41.7),
            (String(localized: "a5_large"), 83.3),
            (String(localized: "a5_luxury"), 166.7)
        ], category: .housing),
        
        Page(number: 6, question: String(localized: "q6_electricity"), answers: [
            (String(localized: "a6_less_100"), 50.0),
            (String(localized: "a6_100_300"), 150.0),
            (String(localized: "a6_300_600"), 300.0),
            (String(localized: "a6_more_600"), 600.0)
        ], category: .energy),
        
        Page(number: 7, question: String(localized: "q7_waste"), answers: [
            (String(localized: "a7_recycle_all"), 10.0),
            (String(localized: "a7_recycle_most"), 50.0),
            (String(localized: "a7_no_recycle"), 150.0),
            (String(localized: "a7_waste_lot"), 300.0)
        ], category: .lifestyle),
        
        Page(number: 8, question: String(localized: "q8_shopping"), answers: [
            (String(localized: "a8_rarely"), 4.2),
            (String(localized: "a8_occasionally"), 12.5),
            (String(localized: "a8_frequently"), 41.7),
            (String(localized: "a8_regularly"), 83.3)
        ], category: .lifestyle),
        
        Page(number: 9, question: String(localized: "q9_energy"), answers: [
            (String(localized: "a9_renewable"), 0.0),
            (String(localized: "a9_mostly_renewable"), 16.7),
            (String(localized: "a9_mixed"), 41.7),
            (String(localized: "a9_fossil"), 83.3)
        ], category: .energy),
        
        Page(number: 10, question: String(localized: "q10_water"), answers: [
            (String(localized: "a10_very_little"), 6.7),
            (String(localized: "a10_moderate"), 20.0),
            (String(localized: "a10_high"), 50.0),
            (String(localized: "a10_excessive"), 100.0)
        ], category: .water)
    ]

    @State private var currentIndex: Int = 0
    @State private var selectedAnswers: [Int: String] = [:]
    @State private var progressPercentage: Double = 0.0
    @State private var score = 0.0
    
    // Add category scores for tracking during questionnaire
    @State private var categoryScores: [QuestionCategory: Double] = [:]
    
    var body: some View {
        ZStack {
            Color(red: 0, green: 0.12, blue: 0.08)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                CarouselCircularProgressView(progress: progressPercentage)
                    .frame(width: 100, height: 100)
                    .padding(.top, 60)
          
                Spacer()
                
                ZStack {
                    ForEach(Array(zip(pages.indices, pages)), id: \.0) { index, page in
                        CarouselCardView(
                            page: page,
                            currentIndex: currentIndex,
                            onAnswerSelected: { answer in
                                withAnimation {
                                    selectedAnswers[index] = answer
                                    progressPercentage = Double(index + 1) / Double(pages.count)
                                    
                                    // Find the corresponding score from the tuple
                                    if let selectedValue = pages[index].answers.first(where: { $0.0 == answer })?.1 {
                                        score += selectedValue
                                        
                                        // Update category score
                                        let category = page.category
                                        categoryScores[category] = (categoryScores[category] ?? 0.0) + selectedValue
                                    }
                                    
                                    if progressPercentage == 1.0 {
                                        isAnswered = true
                                        carbonFootprintScore = score
                                        
                                        // Save category scores to AppStorage
                                        transportationScore = categoryScores[.transportation] ?? 0.0
                                        foodScore = categoryScores[.food] ?? 0.0
                                        housingScore = categoryScores[.housing] ?? 0.0
                                        energyScore = categoryScores[.energy] ?? 0.0
                                        lifestyleScore = categoryScores[.lifestyle] ?? 0.0
                                        waterScore = categoryScores[.water] ?? 0.0
                                        
                                        print("Final Carbon Footprint Score: \(carbonFootprintScore) kg CO₂/month")
                                    }
                                }
                                
                                if currentIndex < pages.count - 1 {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                                        withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                                            currentIndex += 1
                                        }
                                    }
                                }
                            }
                        )
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                Spacer()
            }
        }
    }
}

struct CarouselEffect: ViewModifier {
    let index: Int
    let currentIndex: Int
    let translation: CGFloat
    
    func body(content: Content) -> some View {
        content
            .rotation3DEffect(
                .degrees(Double(index - currentIndex) * 20),
                axis: (x: 0, y: 1, z: 0),
                perspective: 0.5
            )
            .offset(x: CGFloat(index - currentIndex) * 300 + translation)
            .opacity(index == currentIndex ? 1 : 0.3) // Ridotta l'opacità da 0.5 a 0.3
            .scaleEffect(index == currentIndex ? 1 : 0.8)
            .zIndex(index == currentIndex ? 1 : 0)
            .animation(.spring(response: 0.5, dampingFraction: 0.8), value: currentIndex)
    }
}



struct CarouselCircularProgressView: View {
    
    let progress: Double
    @State private var phase = 0.0
    @StateObject var motion: MotionManager1 = MotionManager1()

    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 8)
                .opacity(0.3)
                .foregroundColor(.white)
            
            GeometryReader { geometry in
                ZStack {
                    WaveShape(progress: progress, waveHeight: 5, phase: phase)
                        .fill(Color(red: 0.2, green: 0.6, blue: 0.9).opacity(0.8))
                        .rotation3DEffect(.init(radians: .pi), axis: (motion.fx/2, motion.fy/2, 0))
                    
                    WaveShape(progress: progress, waveHeight: 5, phase: phase + .pi)
                        .fill(Color(red: 0.1, green: 0.4, blue: 0.8).opacity(0.6))
                        .rotation3DEffect(.init(radians: .pi), axis: (motion.fx/2, motion.fy/2, 0))
                }
            }
            .clipShape(Circle())
            .onAppear {
                withAnimation(
                    .linear(duration: 2)
                    .repeatForever(autoreverses: false)
                ) {
                    phase += .pi * 2
                }
            }
            
            Circle()
                .fill(
                    LinearGradient(
                        colors: [.white.opacity(0.2), .clear],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
            
            Text("\(Int(progress * 100))%")
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.white)
        }
    }
}
struct WaveShape: Shape {
    var progress: Double
    var waveHeight: CGFloat = 10
    var phase: Double
    
    var animatableData: Double {
        get { phase }
        set { phase = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let progressHeight = (1 - progress) * rect.height
        let midy = progressHeight
        
        path.move(to: CGPoint(x: 0, y: midy))
        for x in stride(from: 0, through: rect.width, by: 2) {
            let relativeX = x / rect.width
            let sine = sin(relativeX * .pi * 2 + phase)
            let y = midy + sine * waveHeight
            path.addLine(to: CGPoint(x: x, y: y))
        }
        path.addLine(to: CGPoint(x: rect.width, y: rect.height))
        path.addLine(to: CGPoint(x: 0, y: rect.height))
        path.closeSubpath()
        return path
    }
}

import CoreMotion

class MotionManager1: ObservableObject {
    private let motionManager = CMMotionManager()
    
    var fx: CGFloat = 0
    var fy: CGFloat = 0
    var fz: CGFloat = 0
    
    var dx: Double = 0
    var dy: Double = 0
    var dz: Double = 0
    
    init() {
        motionManager.startDeviceMotionUpdates(to: .main) { data, error in
            guard let newData = data?.gravity else { return }
            
            self.dx = newData.x
            self.dy = newData.y
            self.dz = newData.z
            
            self.fx = CGFloat(newData.x)
            self.fy = CGFloat(newData.y)
            self.fz = CGFloat(newData.z)
            
            self.objectWillChange.send()
        }
    }
    
    func shutdown() {
        motionManager.stopDeviceMotionUpdates()
    }
}

#Preview {
    CarouselView()
       
}
