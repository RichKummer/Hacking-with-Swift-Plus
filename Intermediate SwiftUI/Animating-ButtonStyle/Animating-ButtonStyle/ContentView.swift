//
//  ContentView.swift
//  Animating-ButtonStyle
//
//  Created by RichK on 1/29/22.
//

import SwiftUI

//this worked for animation in ButtonStyle:

struct PulsingButtonStyle: ButtonStyle {
    @State private var animation = 0.0

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color.blue)
            .clipShape(Circle())
            .foregroundColor(.white)
            .padding()
            .overlay(
                Circle()
                    .stroke(Color.blue, lineWidth: 2)
                    .scaleEffect(CGFloat(1 + animation))
                    .opacity(1 - animation)
            )
            .onAppear {
                withAnimation(Animation.easeOut(duration: 1).repeatForever(autoreverses: false)) {
                    animation = 1
                }
            }
    }
}

struct SpinningArcsButton: ButtonStyle {
    @State private var animation = 0.0

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color.blue)
            .clipShape(Circle())
            .foregroundColor(.white)
            .padding()
            .overlay(
                Circle()
                    .trim(from: 0, to: 0.5)
                    .stroke(Color.blue, lineWidth: 4)
                    .rotationEffect(.init(degrees: -animation * 360))
            )
            .padding(6)
            .overlay(
                Circle()
                    .trim(from: 0, to: 0.5)
                    .stroke(Color.blue, lineWidth: 4)
                    .rotationEffect(.init(degrees: animation * 360))
            )
            .onAppear {
                withAnimation(Animation.easeOut(duration: 1).repeatForever(autoreverses: false)) {
                    animation = 1
                }
            }
    }
}


struct ContentView: View {

    var body: some View {
        Button {
            print("Pressed")
        } label: {
            Image(systemName: "star")
        }
        .buttonStyle(SpinningArcsButton())
    }
}
        

//protocol AnimatingButtonStyle: ButtonStyle {
//    init(animation: Double)
//}
//
//struct PulsingButtonStyle: ButtonStyle {
//    let animation: Double
//
//    func makeBody(configuration: Configuration) -> some View {
//        configuration.label
//            .padding()
//            .background(Color.blue)
//            .clipShape(Circle())
//            .foregroundColor(.white)
//            .padding()
//            .overlay(
//                Circle()
//                    .stroke(Color.blue, lineWidth: 2)
//                    .scaleEffect(CGFloat(1 + animation))
//                    .opacity(1 - animation)
//            )
//    }
//}
//
//struct SpinningArcsButton: AnimatingButtonStyle {
//    let animation: Double
//    func makeBody(configuration: Configuration) -> some View {
//        configuration.label
//            .padding()
//            .background(Color.blue)
//            .clipShape(Circle())
//            .foregroundColor(.white)
//            .padding()
//            .overlay(
//                Circle()
//                    .trim(from: 0, to: 0.5)
//                    .stroke(Color.blue, lineWidth: 4)
//                    .rotationEffect(.init(degrees: -animation * 360))
//            )
//            .padding(6)
//            .overlay(
//                Circle()
//                    .trim(from: 0, to: 0.5)
//                    .stroke(Color.blue, lineWidth: 4)
//                    .rotationEffect(.init(degrees: animation * 360))
//            )
//    }
//}
//
//struct AnimatedButton<ButtonStyle: AnimatingArcsButtonStyle, Content: View>: View {
//    let buttonStyle: ButtonStyle.Type
//    let action: () -> Void
//    let label: () -> Content
//    var animationSpeed = 5.0
//
//    @State private var animation = 0.0
//
//    var body: some View {
//        Button(action: action, label: label)
//            .buttonStyle(buttonStyle.init(animation: animation))
//            .onAppear {
//                withAnimation(Animation.easeOut(duration: animationSpeed).repeatForever(autoreverses: false)) {
//                    animation = 1
//                }
//            }
//    }
//}
//
//
//struct ContentView: View {
//
//    var body: some View {
//        AnimatedButton(buttonStyle: PulsingButtonStyle.self, animationSpeed: 2) {
//            print("Pressed")
//        } label: {
//            Image(systemName: "star")
//        }
//    }
//}
        

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


