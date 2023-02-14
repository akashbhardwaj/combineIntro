//: [Previous](@previous)

import Foundation
import Combine
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

let subsciption: AnyCancellable? =
Timer.publish(every: 0.5, on: .main, in: .common)
    .autoconnect()
    .throttle(for: .seconds(2), scheduler: DispatchQueue.main, latest: true)
    .scan(0, { count, _ in
        return count + 1
    })
    .filter({ count in
        return count <= 5
    })
    .sink { completion in
        print("Stream completion\(completion)")
    } receiveValue: { timeStamp in
        print("Time is \(timeStamp)")
    }

DispatchQueue.main.asyncAfter(deadline: .now()  + 20) {
//    Ways to cancel a subscription
//    subsciption = nil
    subsciption?.cancel()
}

//: [Next](@next)
