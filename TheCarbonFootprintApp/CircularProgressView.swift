//
//  CircularProgressView.swift
//  TheCarbonFootprintApp
//
//  Created by Trae AI on 06/03/25.
//



import SwiftUI
import CoreMotion

class MotionManager: ObservableObject {
    private let motionManager = CMMotionManager()
    @Published var xTilt: Double = 0
    @Published var yTilt: Double = 0
    @Published var rotation: Double = 0
    
    init() {
        // Verifica se il dispositivo supporta il rilevamento del movimento
        guard motionManager.isDeviceMotionAvailable else {
            print("Device motion is not available")
            return
        }
        
        // Imposta un intervallo di aggiornamento più frequente
        motionManager.deviceMotionUpdateInterval = 1/60
        
        // Avvia gli aggiornamenti del movimento
        motionManager.startDeviceMotionUpdates(to: .main) { [weak self] data, error in
            guard let data = data, error == nil else { return }
            
            // Ottieni l'angolo di inclinazione
            self?.xTilt = data.gravity.x * 2.0
            self?.yTilt = data.gravity.y * 2.0
            
            // Calcola un valore di rotazione basato sull'orientamento del dispositivo
            if let x = self?.xTilt, let y = self?.yTilt {
                self?.rotation = atan2(y, x) * 180 / .pi
            }
        }
    }
    
    deinit {
        motionManager.stopDeviceMotionUpdates()
    }
}

struct CircularProgressView: View {
    var progress: Double
    var color: Color = .blue
    @StateObject private var motionManager = MotionManager()
    
    var body: some View {
        ZStack {
            // Cerchio esterno
            Circle()
                .stroke(lineWidth: 10)
                .opacity(0.3)
                .foregroundColor(color)
            
            // Cerchio di progresso
            Circle()
                .trim(from: 0.0, to: CGFloat(min(self.progress, 1.0)))
                .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                .foregroundColor(color)
                .rotationEffect(Angle(degrees: 270.0))
                .animation(.linear, value: progress)
            
            // Effetto acqua con rotazione
            Circle()
                .trim(from: 0.0, to: CGFloat(min(self.progress, 1.0)))
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [color.opacity(0.8), color.opacity(0.3)]),
                        startPoint: UnitPoint(x: 0.5 + motionManager.xTilt * 0.3, 
                                             y: 0.5 + motionManager.yTilt * 0.3),
                        endPoint: UnitPoint(x: 0.5 - motionManager.xTilt * 0.3, 
                                           y: 0.5 - motionManager.yTilt * 0.3)
                    )
                )
                .rotationEffect(Angle(degrees: motionManager.rotation))
                .animation(.interpolatingSpring(stiffness: 60, damping: 8), value: motionManager.rotation)
                .clipShape(Circle())
        }
    }
}

#Preview {
    CircularProgressView(progress: 0.7)
        .frame(width: 150, height: 150)
}
