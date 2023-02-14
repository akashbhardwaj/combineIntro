//: [Previous](@previous)

import Foundation
import Combine
import PlaygroundSupport
import SwiftUI
PlaygroundPage.current.needsIndefiniteExecution = true


class ScoreModel: ObservableObject {
    @Published var score: Int = 0
    
    init() {
        let timerPubliser = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
        (0...100).publisher
            .zip(timerPubliser)
            .map({$0.0})
            .assign(to: &$score)
    }
}

struct ScoreCardView: View {
    
    @StateObject var scoreModel = ScoreModel()
    
    var body: some View {
        HStack {
            Image(systemName: "football")
                .padding(10)
            Text("The score is \(scoreModel.score)")
                .font(.largeTitle)
                .fixedSize()
                .padding()
        }
    }
}
PlaygroundPage.current.setLiveView(ScoreCardView())
//: [Next](@next)
