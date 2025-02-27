import SwiftUI

struct CircularProgressView: View {
    var progress: Double
    var color1: Color = Color.green
    var color2: Color = Color.white.opacity(0.8)
    
    var body: some View {
        ZStack {
            Circle()
                .trim(from: 0, to: 1) 
                .stroke(Color.black.opacity(0.2), style: StrokeStyle(lineWidth: 5, lineCap: .round))
                .rotationEffect(.degrees(-90)) 
            
            Circle()
                .trim(from: 0, to: progress) 
                .stroke(
                    LinearGradient(gradient: Gradient(colors: [color2, color1]),
                                 startPoint: .leading,
                                 endPoint: .trailing),
                    style: StrokeStyle(lineWidth: 5, lineCap: .round)
                )
                .rotationEffect(.degrees(-90)) 
        }
    }
}

#Preview {
    CircularProgressView(progress: 0.8)
}
