//: [Previous](@previous)

import Foundation
import Combine
/*
 assign(to:) can often lead to memory leaks or retain cycles here is an example how
 
 Apple Doc: The Subscribers.Assign instance created by this operator maintains a strong reference to object, and sets it to nil when the upstream publisher completes (either normally or with an error).
 */
struct ScoreData {
    var score: Int
    var playingPlayer: String
}

class ScoreCardView {
    var scoreData = CurrentValueSubject<ScoreData, Never>(ScoreData(score: 2, playingPlayer: "Dhoni"))
    
    var scoreLabel: String = "" {
        didSet {
            print(scoreLabel)
        }
    }
    var subsciptions = Set<AnyCancellable>()
    
    init() {
        scoreData
            .map({"Score is \($0.score ) playing: \($0.playingPlayer)"})
        /*
            Step 1:
            .assign(to: \.scoreLabel, on: self)
         */
            .sink(receiveValue: { [unowned self] score in // Step 2:
                self.scoreLabel = score // Here is the memory leak
            })
            .store(in: &subsciptions)
        
    }
    
    deinit {
        print("Bbye score card view")
    }
}

var scoreCardView: ScoreCardView? = ScoreCardView()
scoreCardView?.scoreData.send(ScoreData(score: 4, playingPlayer: "Sehwag"))
scoreCardView = nil
/* Output with Step: 1
 Score is 2 playing: Dhoni
 Score is 4 playing: Sehwag
 
 Output with Step 2:
 Score is 2 playing: Dhoni
 Score is 4 playing: Sehwag
 Bbye score card view
 */
//: [Next](@next)
