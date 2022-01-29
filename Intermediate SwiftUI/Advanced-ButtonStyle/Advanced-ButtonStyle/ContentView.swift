//
//  ContentView.swift
//  Advanced-ButtonStyle
//
//  Created by RichK on 1/29/22.
//

import SwiftUI

extension View {
    public func foregroundMask<Content: View> (_ overlay: Content) -> some View {
        self
            .overlay(overlay)
            .mask(self)
    }
}

struct AquaButtonStyle: ButtonStyle {
    let blueHighlight = Color(red: 0.7, green: 1, blue: 1)
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .padding(.horizontal, 20)
            .background(
                ZStack {
                    Color(red: 0.3, green: 0.6, blue: 1)
                    
                    Capsule()
                        .inset(by: 8)
                        .offset(y: 8)
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [blueHighlight.opacity(0), blueHighlight]),
                                startPoint: .top,
                                endPoint: UnitPoint(x: 0.5, y: 0.8)
                            )
                        )
                        .scaleEffect(y: 0.7, anchor: .bottom)
                        .blur(radius: 10)
                    
                    Capsule()
                        .inset(by: 4)
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [Color.white, Color.white.opacity(0)]), startPoint: .top, endPoint: UnitPoint(x: 0.5, y: 0.8)
                            )
                            
                    )
                        .scaleEffect(x: 0.95, y: 0.7, anchor: .top)
                    
                    if configuration.isPressed {
                        Color.blue.opacity(0.2)
                    }
                    
                }
            )
            .clipShape(Capsule())
            .overlay(
                Capsule()
                    .strokeBorder(Color.black.opacity(0.25), lineWidth: 1)
            )
    }
}

struct FantasyButtonStyle: ButtonStyle {
    var foregroundGradientStart = Color(red: 1, green: 0.85, blue: 0.85)
    var foregroundGradientEnd = Color(red: 1, green: 0.65, blue: 0.3)
    
    var backgroundGradientStart = Color(red: 0.33, green: 0.06, blue: 0.1)
    var backgroundGradientEnd = Color(red: 0.5, green: 0.1, blue: 0.1)
    
    var rimGradientStart = Color(red: 0.725, green: 0.55, blue: 0.3)
    var rimGradientEnd = Color(red: 0.2, green: 0.13, blue: 0.05)
    
    private var foregroundGradient: LinearGradient {
        LinearGradient(gradient: Gradient(colors: [foregroundGradientStart, foregroundGradientEnd]), startPoint: .top, endPoint: .bottom)
    }
    
    private var backgroundGradient: LinearGradient {
        LinearGradient(gradient: Gradient(stops: [
            .init(color: backgroundGradientStart, location: 0),
            .init(color: backgroundGradientEnd, location: 0.3),
            .init(color: backgroundGradientEnd, location: 0.7),
            .init(color: backgroundGradientStart, location: 1)
        ]),
        startPoint: .leading,
        endPoint: .trailing)
    }
    
    private var rimGradient: LinearGradient {
        LinearGradient(
            gradient: Gradient(stops: [
                .init(color: rimGradientStart, location: 0),
                .init(color: rimGradientStart, location: 0.49),
                .init(color: rimGradientEnd, location: 0.51),
                .init(color: rimGradientEnd, location: 1),
            ]),
            startPoint: UnitPoint(x: 0.47, y: 0),
            endPoint: UnitPoint(x: 0.53, y: 1))
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .foregroundMask(foregroundGradient)
            .font(Font.system(.largeTitle, design: .serif).lowercaseSmallCaps())
            .textCase(.uppercase)
            .shadow(color: .black, radius: 5, x: 3, y: 3)
            .padding()
            .background(
                ZStack {
                    backgroundGradient
                    
                    if configuration.isPressed {
                        Color.black.opacity(0.3)
                    }
                }
            )
            .overlay(
                Rectangle()
                    .stroke(Color.black, lineWidth: 8)
                    .blur(radius: 8)
                    .mask(Rectangle())
            )
            .overlay(
                Rectangle()
                    .strokeBorder(rimGradientStart, lineWidth: 1)
                    .padding(2)
                    .overlay(
                        Rectangle()
                            .strokeBorder(rimGradient, lineWidth: 2)
                    )
            )
    }
}

struct TargetButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.largeTitle)
            .foregroundColor(.white)
            .padding(40)
            .background(
                RadialGradient(
                    gradient: Gradient(colors: [Color.blue, Color.blue.opacity(0)]),
                    center: .center,
                    startRadius: 5,
                    endRadius: 50
                    )
                    .opacity(configuration.isPressed ? 0.7 : 1)
            )
            .overlay(circle(with: configuration))
            .overlay(circle(with: configuration).rotationEffect(.init(degrees: 90)))
            .overlay(circle(with: configuration).rotationEffect(.init(degrees: 180)))
            .overlay(circle(with: configuration).rotationEffect(.init(degrees: 270)))
            .overlay(tick(with: configuration))
            .overlay(tick(with: configuration).rotationEffect(.init(degrees: 90)))
            .overlay(tick(with: configuration).rotationEffect(.init(degrees: 180)))
            .overlay(tick(with: configuration).rotationEffect(.init(degrees: 270)))

    }
    
    func circle(with configuration: Configuration) -> some View {
        Circle()
            .trim(from: 0.05, to: 0.2)
            .stroke(Color.white, lineWidth: 5)
            .shadow(color: Color.blue, radius: 5)
            .shadow(color: Color.blue, radius: 5)
            .shadow(color: Color.blue, radius: 5)
            .scaleEffect(configuration.isPressed ? 0.8 : 1)
    }
    
    func tick(with configuration: Configuration) -> some View {
        Circle()
            .trim(from: 0.24, to: 0.26)
            .stroke(Color.white, lineWidth: 20)
            .shadow(color: Color.blue, radius: 5)
            .shadow(color: Color.blue, radius: 5)
            .shadow(color: Color.blue, radius: 5)
            .scaleEffect(configuration.isPressed ? 0.8 : 1)
    }
}

struct ContentView: View {
    var body: some View {
        ZStack {
            Button {
                print("Pressed")
            } label: {
                Image(systemName: "star")
            }
            .buttonStyle(TargetButtonStyle())
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
