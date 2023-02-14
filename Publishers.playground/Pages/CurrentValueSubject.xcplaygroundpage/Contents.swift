//: [Previous](@previous)

import Foundation
import Combine

// Subject: - A subject is a publisher which you can continuously pass new values down

struct UserData {
    var userID: Int
    var name: String
}

let currentUserIdSubject = CurrentValueSubject<Int, Never>(100)
let currentUserDataSubject = CurrentValueSubject<UserData, Never>(UserData(userID: 134, name: "Jhon"))

// Getting value
print(currentUserIdSubject.value)

// Subscribing the subject

currentUserDataSubject
    .sink(receiveCompletion: { completion in
        print("Completion \(completion)")
    }, receiveValue: { value in
        print("Value \(value.name)")
    })

// Publishing new value

currentUserDataSubject.send(UserData(userID: 345, name: "Apple"))

// Publishing completions

currentUserDataSubject.send(completion: .finished)

currentUserDataSubject.send(UserData(userID: 000, name: "After Completion")) // Will not be consumed by subscriber as we have published completion already
//: [Next](@next)
