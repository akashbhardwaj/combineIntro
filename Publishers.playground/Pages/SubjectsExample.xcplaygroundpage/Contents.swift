//: [Previous](@previous)

import Foundation
import Combine

class AppLogins {
    private let userNameStorage = CurrentValueSubject<[String], Never>(["Bob"])
    var userNames: AnyPublisher<[String], Never>
    
    let newUsernameEntered = PassthroughSubject<String, Never>()
    var subscriptions = Set<AnyCancellable>()
    
    init() {
        userNames = userNameStorage.eraseToAnyPublisher()
        
        newUsernameEntered
            .filter({$0.count > 3})
            .sink { completion in
                print("Received Completion \(completion)")
            } receiveValue: { [unowned self] userName in
                self.userNameStorage.send(self.userNameStorage.value + [userName])
            }
            .store(in: &subscriptions)

        
    }
}

// Passing new user name

let appLogins = AppLogins()
appLogins.newUsernameEntered.send("Apple")
appLogins.newUsernameEntered.send("Lo")


// NO send function as the publisher's type is earased to Anypublisher with eraseToAnyPublisher() function it is only read only publisher
//appLogins.userNames.send



let subs = appLogins.userNames.sink { userNames in
    print("User in system are: ", userNames)
}




//: [Next](@next)
