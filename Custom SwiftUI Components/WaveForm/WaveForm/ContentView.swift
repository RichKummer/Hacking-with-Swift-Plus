//
//  ContentView.swift
//  WaveForm
//
//  Created by RichK on 8/30/20.
//

import SwiftUI

struct Wave: Shape {
    var strength: Double
    var frequency: Double
    var phase: Double
    
    var animatableData: Double {
        get { phase }
        set { self.phase = newValue}
    }
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath()
        
        let width = Double(rect.width)
        let height = Double(rect.height)
        let midWidth = width / 2
        let midHeight = height / 2
        let oneOverMidWidth = 1 / midWidth
        
        let wavelength = width / frequency
        
        path.move(to: CGPoint(x: 0, y: midHeight))
        
        for x in stride(from: 0, through: width, by: 1) {
            let relativeX = x / wavelength
            let distanceFromMidWidth = x - midWidth
            let normalDistance = oneOverMidWidth * distanceFromMidWidth
            let parabola = -(normalDistance) * normalDistance + 1
            
            let sine = sin(relativeX + phase)
            let y = parabola * strength * sine + midHeight
            path.addLine(to: CGPoint(x: x, y: y))
        }
        
        return Path(path.cgPath)
    }
}


struct ContentView: View {
    @State private var phase = 0.0
    
    var body: some View {
        ZStack {
            //Single Wave
            //Wave(strength: 50, frequency: 30, phase: 0)
                //.stroke(Color.white, lineWidth: 5)
            
            ForEach(0..<5) { i in
            Wave(strength: 50, frequency: 10, phase: phase)
                .stroke(Color.white.opacity(Double(i) / 5), lineWidth: 5)
                .offset(y: CGFloat(i) * 10)
            }
        }
        .background(Color.blue)
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            withAnimation(Animation.linear(duration: 1).repeatForever(autoreverses: false)) {
                self.phase = .pi * 2
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
