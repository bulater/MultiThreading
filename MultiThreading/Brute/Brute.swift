//
//  Brute.swift
//  MultiThreading
//
//  Created by Илья Белкин on 02.11.2022.
//

import Foundation

final class Brute {
    var stoppedBruteForce = false
    
    func bruteForce(_ passwordView: PasswordView, passwordToUnlock: String) {
        let allowedCharacters: [String] = String().printable.map { String($0) }
        var password: String = ""
        
        while password != passwordToUnlock {
            if stoppedBruteForce {
                DispatchQueue.main.async {
                    let failedText = "Password: \n\(passwordView.passwordTextField.text ?? "")\n is not cracked!"
                    passwordView.passwordLabel.text = failedText
                    passwordView.isBlackBGColor()
                }
                break
            }
            password = generateBruteForce(password, fromArray: allowedCharacters)
            DispatchQueue.main.async {
                passwordView.passwordLabel.text = password
            }
        }
        
        if !stoppedBruteForce {
            DispatchQueue.main.async {
                let successText = "Password detected: \n\(password)"
                passwordView.passwordLabel.text = successText
                passwordView.passwordLabel.textColor = .systemGreen
                passwordView.passwordTextField.isSecureTextEntry = false
                passwordView.passwordProgress.isHidden = true
                passwordView.passwordProgress.stopAnimating()
            }
        }
    }
    
    private func generateBruteForce(_ string: String, fromArray array: [String]) -> String {
        var generatedPassword: String = string
        
        if generatedPassword.count <= 0 {
            generatedPassword.append(characterAt(index: 0, array))
        }
        else {
            generatedPassword.replace(at: generatedPassword.count - 1,
                        with: characterAt(index: (indexOf(character: generatedPassword.last ?? " ", array) + 1) % array.count, array))
            
            if indexOf(character: generatedPassword.last!, array) == 0 {
                generatedPassword = String(generateBruteForce(String(generatedPassword.dropLast()), fromArray: array)) + String(generatedPassword.last ?? " ")
            }
        }
        
        return generatedPassword
    }

    private func characterAt(index: Int, _ array: [String]) -> Character {
        return index < array.count ? Character(array[index])
        : Character("")
    }

    private func indexOf(character: Character, _ array: [String]) -> Int {
        return array.firstIndex(of: String(character))!
    }
}
