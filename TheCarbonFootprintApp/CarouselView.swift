import SwiftUI

struct Page: Identifiable {
    let id = UUID()
    let number: Int
    let question: String
    let answers: [(String, Double)]
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


    private let pages = [
        Page(number: 1, question: "How often do you use a car for transportation?", answers: [
            ("Never", 0.0),
            ("Occasionally", 50.0),
            ("Regularly", 150.0),
            ("Daily", 300.0)
        ]),
        
        Page(number: 2, question: "What type of diet do you follow?", answers: [
            ("Vegan", 10.0),
            ("Vegetarian", 30.0),
            ("Omnivore, but limited meat", 80.0),
            ("High meat consumption", 200.0)
        ]),
        
        Page(number: 3, question: "How do you typically heat your home?", answers: [
            ("Renewable energy (solar, geothermal)", 10.0),
            ("Electricity", 50.0),
            ("Natural gas", 150.0),
            ("Coal or oil", 300.0)
        ]),
        
        Page(number: 4, question: "How often do you fly per year?", answers: [
            ("Never", 0.0),
            ("1-2 short flights", 42.0),
            ("3-5 medium-haul flights", 125.0),
            ("More than 5 long-haul flights", 417.0)
        ]),
        
        Page(number: 5, question: "What type of home do you live in?", answers: [
            ("Small apartment (<50m²)", 8.3),
            ("Medium apartment or house (50-150m²)", 41.7),
            ("Large house (>150m²)", 83.3),
            ("Luxury home with high energy use", 166.7)
        ]),
        
        Page(number: 6, question: "How much electricity do you consume monthly?", answers: [
            ("Less than 100 kWh", 50.0),
            ("100-300 kWh", 150.0),
            ("300-600 kWh", 300.0),
            ("More than 600 kWh", 600.0)
        ]),
        
        Page(number: 7, question: "How do you dispose of waste?", answers: [
            ("I recycle and compost everything possible", 10.0),
            ("I recycle most items, but not all", 50.0),
            ("I throw away most of my waste without recycling", 150.0),
            ("I generate a lot of waste and do not recycle", 300.0)
        ]),
        
        Page(number: 8, question: "How often do you buy new clothing or electronics?", answers: [
            ("Rarely, only when necessary", 4.2),
            ("Occasionally, a few items per year", 12.5),
            ("Frequently, new items every few months", 41.7),
            ("Regularly, I follow fashion trends and upgrade often", 83.3)
        ]),
        
        Page(number: 9, question: "What type of energy sources power your home?", answers: [
            ("100% renewable", 0.0),
            ("Mostly renewable with some fossil fuels", 16.7),
            ("Mixed fossil fuels and renewables", 41.7),
            ("Mostly or entirely fossil fuels", 83.3)
        ]),
        
        Page(number: 10, question: "How much water do you use daily?", answers: [
            ("Very little (short showers, minimal waste)", 6.7),
            ("Moderate usage", 20.0),
            ("High usage (bath daily, excessive water use)", 50.0),
            ("Excessive usage (pool, lawn irrigation, long showers)", 100.0)
        ])
    ]

    
    @State private var currentIndex: Int = 0
    @State private var selectedAnswers: [Int: String] = [:]
    @State private var progressPercentage: Double = 0.0
    @State private var score = 0.0
    
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
                                    }
                                    
                                    if progressPercentage == 1.0 {
                                        isAnswered = true
                                        carbonFootprintScore = score
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
            .opacity(index == currentIndex ? 1 : 0.5)
            .scaleEffect(index == currentIndex ? 1 : 0.8)
            .zIndex(index == currentIndex ? 1 : 0)
            .animation(.spring(response: 0.5, dampingFraction: 0.8), value: currentIndex)
    }
}

struct CarouselCircularProgressView: View {
    let progress: Double
    @State private var phase = 0.0
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 8)
                .opacity(0.3)
                .foregroundColor(.white)
            
            GeometryReader { geometry in
                ZStack {
                    WaveShape(progress: progress, waveHeight: 5, phase: phase)
                        .fill(Color.blue.opacity(0.8))
                    
                    WaveShape(progress: progress, waveHeight: 5, phase: phase + .pi)
                        .fill(Color.blue.opacity(0.6))
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

#Preview {
    CarouselView()
}
