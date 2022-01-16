//
//  ContentView.swift
//  BezierPath-Example
//
//  Created by RichK on 8/23/20.
//

import SwiftUI

struct ShapeView: Shape {
    let bezier: UIBezierPath
    
    func path(in rect: CGRect) -> Path {
        let path = Path(bezier.cgPath)
        let multiplier = min(rect.width, rect.height)
        let transform = CGAffineTransform(scaleX: multiplier, y: multiplier)
        return path.applying(transform)
    }
}

struct ContentView: View {
    @State private var endAmount: CGFloat = 0
    
    var body: some View {
        ShapeView(bezier: UIBezierPath.unwrapLogo)
            .trim(from: 0, to: endAmount)
            .stroke(Color(#colorLiteral(red: 0.3803921569, green: 0.3450980392, blue: 0.9215686275, alpha: 1)), lineWidth: 4)
            .frame(width: 200, height: 200)
            .onAppear {
                withAnimation(.easeIn(duration: 3)) {
                    self.endAmount = 1
                }
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension UIBezierPath {
    static var unwrapLogo: UIBezierPath {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0.534, y: 0.5816))
        path.addCurve(to: CGPoint(x: 0.1877, y: 0.088), controlPoint1: CGPoint(x: 0.534, y: 0.5816), controlPoint2: CGPoint(x: 0.2529, y: 0.4205))
        path.addCurve(to: CGPoint(x: 0.9728, y: 0.8259), controlPoint1: CGPoint(x: 0.4922, y: 0.4949), controlPoint2: CGPoint(x: 1.0968, y: 0.4148))
        path.addCurve(to: CGPoint(x: 0.0397, y: 0.5431), controlPoint1: CGPoint(x: 0.7118, y: 0.5248), controlPoint2: CGPoint(x: 0.3329, y: 0.7442))
        path.addCurve(to: CGPoint(x: 0.6211, y: 0.0279), controlPoint1: CGPoint(x: 0.508, y: 1.1956), controlPoint2: CGPoint(x: 1.3042, y: 0.5345))
        path.addCurve(to: CGPoint(x: 0.6904, y: 0.3615), controlPoint1: CGPoint(x: 0.7282, y: 0.2481), controlPoint2: CGPoint(x: 0.6904, y: 0.3615))
        return path
    }
}
