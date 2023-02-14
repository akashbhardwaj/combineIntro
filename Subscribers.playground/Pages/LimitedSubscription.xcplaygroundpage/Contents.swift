//: [Previous](@previous)

import Foundation
import Combine
// Publisher will publish limited values
let scorePublisher: Publishers.Sequence<[Int], Never> = [0, 4, 10, 11, 13, 17, 23, 27, 28].publisher

//let scoreCardSubscription = scorePublisher
//    .sink { completion in
//        print("Score card completion \(completion)")
//    } receiveValue: { score in
//        print("The score is \(score)")
//    }
/* Output
 Here is subscription automatically cancels as publisher finishes publishing value
The score is 0
The score is 4
The score is 10
The score is 11
The score is 13
The score is 17
The score is 23
The score is 27
The score is 28
Score card completion finished
*/



let calendar = Calendar.current
let endDate = calendar.date(byAdding: .second, value: 3, to: Date())!
enum MatchErrors: Error {
    case matchEnded
}

func throwAtMatchEnds(score: Int, timeStamp: Date) throws ->  String {
    if timeStamp < endDate {
        return "Score on \(timeStamp) is \(score)"
    }
    throw MatchErrors.matchEnded
}


let timePublisher = Timer.publish(every: 1, on: .main, in: .common)
    .autoconnect()
// zip is an operator to stitch values from two publishers
let scoreCardSubscriptionWithTime = scorePublisher.zip(timePublisher)
    .tryMap({ try throwAtMatchEnds(score: $0, timeStamp: $1)})
    .sink { completion in
        switch completion {
        case .finished:
            print("Score card completion finished")
        case .failure(let error):
            print("Score card subscription failed with: \(error)")
        }
        print("Score card completion \(completion)")
    } receiveValue: { output in
        print(output)
    }

/** Output

 Score on 2023-02-12 20:22:14 +0000 is 0
 Score on 2023-02-12 20:22:15 +0000 is 4
 Score card subscription failed with: matchEnded
 Score card completion failure(__lldb_expr_50.MatchErrors.matchEnded)
 */

//: [Next](@next)
