//
//  ContentView.swift
//  FlipView
//
//  Created by RichK on 8/9/20.
//

import SwiftUI

struct FlipView<Front: View, Back: View>: View {
    var isFlipped: Bool
    var front: () -> Front
    var back: () -> Back
    
    init(isFlipped: Bool, @ViewBuilder front: @escaping () -> Front, @ViewBuilder back: @escaping () -> Back) {
        self.isFlipped = isFlipped
        self.front = front
        self.back = back
    }
    
    var body: some View {
        ZStack {
            front()
                .rotation3DEffect(
                    .degrees(isFlipped == true ? 180 : 0),
                    axis: (x: 0, y: 1, z: 0)
                )
                .opacity(isFlipped == true ? 0 : 1)
                .accessibility(hidden: isFlipped == true)
            
            back()
                .rotation3DEffect(
                    .degrees(isFlipped == true ? 0 : -180),
                    axis: (x: 0, y: 1, z: 0)
                )
                .opacity(isFlipped == true ? 1 : -1)
                .accessibility(hidden: isFlipped == false)
        }
    }
}

struct ContentView: View {
    @State private var cardFlipped = false
    
    var body: some View {
        FlipView(isFlipped: cardFlipped) {
            Text("Front side")
                .font(.largeTitle)
                .foregroundColor(Color(#colorLiteral(red: 0.1172515313, green: 0.1179613439, blue: 0.5376546637, alpha: 1)))
                .padding()
                .background(Color(#colorLiteral(red: 0.3803921569, green: 0.3450980392, blue: 0.9215686275, alpha: 1)))
                .clipShape(RoundedRectangle(cornerRadius: 25))
        } back: {
            Text("Back side")
                .font(.largeTitle)
                .foregroundColor(Color(#colorLiteral(red: 0.1024734225, green: 0.2493031222, blue: 0.5028949873, alpha: 1)))
                .padding()
                .background(Color(#colorLiteral(red: 0.1215686275, green: 0.6705882353, blue: 0.9215686275, alpha: 1)))
                .clipShape(RoundedRectangle(cornerRadius: 25))
        }
        .animation(.spring(response: 0.35, dampingFraction: 0.7))
        .onTapGesture {
            cardFlipped.toggle()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
