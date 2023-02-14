//: [Previous](@previous)

import Foundation
import Combine

// subscribe(on:) gives the option to publisher to run on the Scheduler provided, but it is not neccessary that the pre defined publisher will run on those provied scheduler


let subscriptions = Set<AnyCancellable>()
let publisher = PassthroughSubject<Int, Never>()

publisher
    .subscribe(on: DispatchQueue.global())
    .sink(receiveValue: { value in
        print("received value \(value) on \(Thread.current)")
    })

publisher.send(1)
publisher.send(2)
DispatchQueue.global().async {
    publisher.send(3)
}

publisher.send(4)

/* Output
 received value 1 on <_NSMainThread: 0x600002dac2c0>{number = 1, name = main}
 received value 2 on <_NSMainThread: 0x600002dac2c0>{number = 1, name = main}
 received value 4 on <_NSMainThread: 0x600002dac2c0>{number = 1, name = main}
 received value 3 on <NSThread: 0x600002d880c0>{number = 8, name = (null)}

 */

//: [Next](@next)
