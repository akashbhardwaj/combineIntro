//: [Previous](@previous)

import Foundation

// @dynamicCallable
@dynamicCallable
struct Repeater {
    func repeatElement(label: String, for times: Int) -> String {
        return Array(repeating: label, count: times).joined(separator: " ")
    }
    func dynamicallyCall(withKeywordArguments pairs: KeyValuePairs<String, Int>) -> String {
        return pairs.map { label, value in
            return self.repeatElement(label: label, for: value)
        }
        .joined(separator: "\n")
    }
}

let repeater = Repeater()

print(repeater(a: 1, b: 2, c: 4))



// @@dynamicMemberLookup

@dynamicMemberLookup
struct ApiResponse {
    var jsonValue: [String: Any]
    
    init(_ json: [String: Any]) {
        self.jsonValue = json
    }
    
    subscript(dynamicMember member: String) -> Any {
        return jsonValue[member] ?? "No value found"
    }
}


let profileResponse = ApiResponse(["name": "John", "employeeId": 12342, "sin": "123-3221-231"])
print(profileResponse.name)
print(profileResponse.employeeId)
print(profileResponse.lastName)


// @propertyWrapper

@propertyWrapper
struct UserDefault<Value> {
    var key: String
    var container = UserDefaults.standard
    var defaultValue: Value
    var wrappedValue: Value {
        set {
            container.set(newValue, forKey: key)
        }
        get {
            return container.value(forKey: key) as? Value ?? defaultValue
        }
    }
}

struct AppConfiguration {
    
    @UserDefault(key: "hasSeenAppIntro", defaultValue: false)
    var hasSeenAppIntro: Bool
    
    func shouldShowAppIntro () -> Bool {
        return !hasSeenAppIntro
    }
}

var configuration = AppConfiguration()
//configuration.hasSeenAppIntro = false // Just to reset
print(configuration.shouldShowAppIntro())
configuration.hasSeenAppIntro = true
print(configuration.shouldShowAppIntro())


