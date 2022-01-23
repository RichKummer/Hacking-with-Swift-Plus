//
//  ContentView.swift
//  Basic ButtonStyle
//
//  Created by RichK on 1/22/22.
//

import SwiftUI

struct EmptyStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
    }
}

struct ColorButtonStyle: ButtonStyle {
    let color: Color
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.vertical)
            .padding(.horizontal, 50)
            .background(color)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .foregroundColor(.white)
            .overlay(Color.black
                .opacity(configuration.isPressed ? 0.3 : 0)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            )
    }
}

struct StripedRectangleButtonStyle: ButtonStyle {
    var offColor = Color.blue
    var onColor = Color.green
    
    func color(for configuration: Configuration) -> Color {
        configuration.isPressed ? onColor : offColor
    }
    
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            Rectangle()
                .fill(color(for: configuration))
                .frame(width: 10)
            
            configuration.label
                .padding()
                .foregroundColor(color(for: configuration))
                .textCase(.uppercase)
                .font(Font.title.bold())
                .border(color(for: configuration), width: 4)
        }
        .fixedSize()
        .animation(nil)
    }
}

struct PushButtonStyle: ButtonStyle {
    let lightGray = Color(white: 0.8)
    
    func makeBody(configuration: Configuration) -> some View {
        let startEdge: UnitPoint
        let endEdge: UnitPoint
        
        if configuration.isPressed {
            startEdge = UnitPoint.bottomTrailing
            endEdge = UnitPoint.topLeading
        } else {
            startEdge = UnitPoint.topTrailing
            endEdge = UnitPoint.bottomTrailing
        }
        
        return configuration.label
            .foregroundColor(Color.black.opacity(configuration.isPressed ? 0.7 : 1))
            .font(.largeTitle)
            .padding(40)
            .background(
                LinearGradient(gradient: Gradient(colors: [lightGray, .white]), startPoint: startEdge, endPoint: endEdge)
              )
            .overlay(
                Circle()
                    .stroke(
                        LinearGradient(gradient: Gradient(colors: [Color.white, lightGray]), startPoint: startEdge, endPoint: endEdge),
                        lineWidth: 16
                       )
                        .padding(2)
                    .overlay(
                        Circle()
                            .stroke(configuration.isPressed ? Color.black : Color.gray, lineWidth: 4)
                    )
                )
            .clipShape(Circle())
            .scaleEffect(configuration.isPressed ? 0.9 : 1)
            .shadow(color: Color.black.opacity(configuration.isPressed ? 0 : 0.2), radius: 10, x: 10, y: 10)
            .animation(nil)
        }
}

extension Color {
    static let classicRed = Color(red: 0.6, green: 0, blue: 0.075)
    static let classicGreen = Color(red: 0, green: 0.6, blue: 0.3)
    static let classicBlue = Color(red: 0, green: 0.2, blue: 0.7)
}

struct GlassButtonStyle: ButtonStyle {
    let color: Color
    
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            configuration.label
                .font(Font.largeTitle.bold())
                .foregroundColor(color)
                .offset(x: -1, y: -1)
            
            configuration.label
                .font(Font.largeTitle.bold())
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(
            color
                .overlay(
                    LinearGradient(gradient: Gradient(stops: [
                        Gradient.Stop(color: Color.white.opacity(0.6), location: 0),
                        Gradient.Stop(color: Color.white.opacity(0.15), location: 0.499),
                        Gradient.Stop(color: Color.white.opacity(0), location: 0.5),
                        Gradient.Stop(color: Color.white.opacity(0), location: 0.8),
                        Gradient.Stop(color: Color.white.opacity(0.2), location: 1),
                    ]), startPoint: .top, endPoint: .bottom)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .strokeBorder(Color.white.opacity(0.4), lineWidth: 1)
                )
        )
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}

struct ContentView: View {
    var body: some View {
        Button {
            print("Pressed")
        } label: {
            HStack {
                Image(systemName: "phone.down.fill")
                Text("Start Call")
            }
        }
        .buttonStyle(GlassButtonStyle(color: .classicGreen))
        .padding(.horizontal)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
