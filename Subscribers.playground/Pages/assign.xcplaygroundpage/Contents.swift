//: [Previous](@previous)

import Foundation
import Combine
// assin(to:on:)
//func assign<Root>(to keyPath: ReferenceWritableKeyPath<Root, Self.Output>, on object: Root) -> AnyCancellable
// enables you to assign the received value to a KVO-complaint property of object

class ScoreCardView {
    var label: String = "" {
        didSet {
            print("Score label is set to: \(label)")
        }
    }
}
let scoreCardView = ScoreCardView()

/* We can assign a vlue by this method
let scoreCardSubscription = (0...10).publisher
    .map({ score in
        return "Score: \(score)"
    })
    .sink(receiveValue: { scoreCardText in
        scoreCardView.label = scoreCardText
    })
 */
// or we can use assign
let scoreCardSubscription = (0...10).publisher
    .map({ score in
        return "Score: \(score)"
    })
    .assign(to: \.label, on: scoreCardView)

/*
 Output in both the cases
 Score label is set to: Score: 0
 Score label is set to: Score: 1
 Score label is set to: Score: 2
 Score label is set to: Score: 3
 Score label is set to: Score: 4
 Score label is set to: Score: 5
 Score label is set to: Score: 6
 Score label is set to: Score: 7
 Score label is set to: Score: 8
 Score label is set to: Score: 9
 Score label is set to: Score: 10

 */

//: [Next](@next)
