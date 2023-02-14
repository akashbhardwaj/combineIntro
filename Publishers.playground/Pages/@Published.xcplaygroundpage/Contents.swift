//: [Previous](@previous)

import Foundation
import Combine

// @Published is a property wrapper on Publishers, it handle the subscription lifecyle automatically

class AppLogins {
    
    
//  let userNames = CurrentValueSubject<[String], Never>(["Bob"])
    
    @Published var userNames: [String] = ["Bob"]
    
    let newUsernameEntered = PassthroughSubject<String, Never>()
    var subscriptions = Set<AnyCancellable>()
    
    init() {
        // Accessing publisher
        $userNames.sink { [unowned self] value in
            // Note
            // Documentation: When the property changes, publishing occurs in the property's willSet block, meaning subscribers receive the new value before it's actually set on the property.
            
            print("User names value changed to \(value) from \(self.userNames) ")
        }
        .store(in: &subscriptions)
        
        newUsernameEntered
            .filter({$0.count > 3})
            .sink { [unowned self] value in
                self.userNames.append(value)
            }
            .store(in: &subscriptions)

    }
}

let appLogins = AppLogins()

// Getting Values

print(appLogins.userNames)


// adding new user
appLogins.newUsernameEntered.send("Apple")

// Cannot send as it is exposed as type erased AnyPublisher
//appLogins.$userNames.send



//: [Next](@next)
