//: [Previous](@previous)

import Foundation
import Combine
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true
let subscription = URLSession.shared.dataTaskPublisher(for: URL(string: "https://jsonplaceholer.typicode.com")!)
    .sink(receiveCompletion: { completion in
        print("receive : ---> ", completion)
    }, receiveValue: { value in
        print("receive value: ", value)
    })

