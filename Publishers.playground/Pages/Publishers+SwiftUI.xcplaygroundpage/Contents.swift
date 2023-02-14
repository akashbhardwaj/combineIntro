//: [Previous](@previous)

import Foundation
import Combine

// SwiftUI used ObservableObject protocol to observe to changes inside an object, which is used to update UI

class AppLogins: ObservableObject {
    
    
//  let userNames = CurrentValueSubject<[String], Never>(["Bob"])
    
    @Published var userNames: [String] = ["Bob"]
    
    let userNameSubject = CurrentValueSubject<[String], Never>(["Bob"])
    var subscriptions = Set<AnyCancellable>()
    
    init() {
        // Accessing publisher
        $userNames.sink { value in
            print("User names value changed to \(value)")
        }
        .store(in: &subscriptions)
        
        userNameSubject.sink { [unowned self] value in
            print("User names subject value changed to \(value)")
            // Last Step
            // self.objectWillChange.send()
        }
        .store(in: &subscriptions)
    }
}

let appLogins = AppLogins()


// ObservableObject wrap the object in a publisher which can we accessed through 'objectWillChange'

let subs = appLogins.objectWillChange.sink { _ in
    print("App login Changed")
}
appLogins.userNames.append("Susan")

/* Output:
 User names value changed to ["Bob"]
 User names value changed to ["Bob"]
 App login Changed
 User names value changed to ["Bob", "Susan"]
 */

// Note: @Published also regiter the properties to notify the oject. So that any change in property can also be published to objectWillChange publisher

print("Now only changing the subject keeping @Published value as it was")
appLogins.userNameSubject.send(["Susan"])
/*
 Output:
 Now only changing the subject keeping @Published value as it was
 User names subject value changed to ["Susan"]
 */

// We can still use Current value subject inside an ObservableObject, just we have to call 'objectWillChange' functions our selfs as we have done in Last Step

//: [Next](@next)
