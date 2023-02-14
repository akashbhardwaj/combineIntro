//: [Previous](@previous)

import Foundation
import Combine
// received(on:) operator helps us to receive value from a publisher on specific thread or Scheduler. receive(on:) change the schedular downstream

let publisher = PassthroughSubject<String, Never>()

let subscription: AnyCancellable = publisher.sink(receiveValue: { value in
    print("Received value \(value)")
    print(Thread.current)
})
/* Output:
 Received value Hey
 <_NSMainThread: 0x600002d804c0>{number = 1, name = main}
 Received value Hello
 <NSThread: 0x600002d9c640>{number = 7, name = (null)}

 */



let newSubscription: AnyCancellable =
    publisher
    .receive(on: RunLoop.main) // or can use DispatchQueue.main
    .sink { value in
        print("Received value \(value)")
        print(Thread.current)
    }
/*
 Received value Hey
 <_NSMainThread: 0x600002b6c200>{number = 1, name = main}
 Received value Hello
 <_NSMainThread: 0x600002b6c200>{number = 1, name = main}
 */


publisher.send("Hey")

DispatchQueue.global().async {
    publisher.send("Hello")
}



//: [Next](@next)
