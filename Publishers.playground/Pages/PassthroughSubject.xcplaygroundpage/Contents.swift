//: [Previous](@previous)

import Foundation
import Combine
// Passthrough Subject: Publisher that you can continuously pass value down to

// Most used for actions / process, like functions

let userNameEntered = PassthroughSubject<String, Never>()

// Getting value of userNameEntered
// Does not hold any value userNameEntered.value

// Subscribe
let subscription = userNameEntered.sink { completion in
    print("User name entered completion \(completion)")
} receiveValue: { value in
    print("User name is \(value)")
}

// Passing values
userNameEntered.send("Jhon")

// Sending Completion
userNameEntered.send(completion: .finished)

userNameEntered.send("dasda") // No published as already finished

//: [Next](@next)
