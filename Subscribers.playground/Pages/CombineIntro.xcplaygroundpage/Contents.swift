import UIKit
import Combine

enum WeatherError: Error {
    case noInternetConnection
}
var weatherPubliser = PassthroughSubject<Int, WeatherError>()

var eventsSubscriber = weatherPubliser.handleEvents (receiveSubscription: { subs in
    print("Receive subscription \(subs)")
}, receiveOutput: { temp in
    print("Receive output \(temp)")
}, receiveCompletion: { completion in
    print("Receive completion \(completion)")
}, receiveCancel: {
    print("Receive cancel")
}, receiveRequest:  { demand in
    print("Receive request \(demand)")
}).sink { completion in
    print("Sink completion \(completion)")
} receiveValue: { temp in
    print("Sink temp is \(temp)")
}


//var subsciber = weatherPubliser.sink(receiveCompletion: <#T##((Subscribers.Completion<Error>) -> Void)##((Subscribers.Completion<Error>) -> Void)##(Subscribers.Completion<Error>) -> Void#>, receiveValue: <#T##((Int) -> Void)##((Int) -> Void)##(Int) -> Void#>)



weatherPubliser.send(1)
weatherPubliser.send(2)
weatherPubliser.send(3)
weatherPubliser.send(4)
weatherPubliser.send(completion: Subscribers.Completion<WeatherError>.failure(.noInternetConnection))
weatherPubliser.send(5)
weatherPubliser.send(6)





