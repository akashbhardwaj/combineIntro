//: [Previous](@previous)

import Foundation
import Combine
import PlaygroundSupport
import UIKit
var greeting = "Hello, playground"

class ScoreboardViewController: UIViewController {
    var nameLabel: UILabel = UILabel()
    var nameTextField: UITextField!
    
    var subscriptions = Set<AnyCancellable>()
    var nameMessage = CurrentValueSubject<String, Never>("No Value entered")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeLayout()
        nameTextField.addTarget(self, action: #selector(textValueUpdated), for: .editingChanged)
        nameMessage
            .compactMap({"My Name is \($0)"})
            .assign(to: \.text, on: nameLabel)
            .store(in: &subscriptions) // inout parameter
    }
    
    func makeLayout() {
        view.backgroundColor = .cyan
        nameTextField = UITextField()
        view.addSubview(nameTextField)
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.placeholder = "Enter your name"
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 20),
        ])
        
        view.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.text = "Please enter name"
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 20),
        ])
    }
    
    @objc
    func textValueUpdated() {
        self.nameMessage.value = nameTextField.text ?? ""
    }
}

let scoreboradViewController = ScoreboardViewController()
PlaygroundPage.current.setLiveView(scoreboradViewController)
//: [Next](@next)

