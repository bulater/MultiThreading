//
//  PasswordViewController.swift
//  MultiThreading
//
//  Created by Илья Белкин on 02.11.2022.
//

import UIKit

final class PasswordViewController: UIViewController {
    
    var brute = Brute()
    
    override func loadView() {
        super.loadView()
        let view = PasswordView()
        self.view = view
        view.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

extension PasswordViewController: PasswordViewDelegate {
    func startButtonTapped(_ passwordView: PasswordView) {
        if passwordView.passwordTextField.text == "" {
            let alert = UIAlertController(title: "Error", message: "Enter Password!", preferredStyle: .alert)
            let actionOK = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(actionOK)
            present(alert, animated: true)
        } else {
            brute.stoppedBruteForce = false
            if let password = passwordView.passwordTextField.text {
                let queue = DispatchQueue(label: "bruteforce",
                                          qos: .background,
                                          attributes: .concurrent)
                queue.async {
                    self.brute.bruteForce(passwordView, passwordToUnlock: password)
                }
                passwordView.passwordProgress.isHidden = false
                passwordView.passwordProgress.startAnimating()
            }
        }
    }
    
    func stopButtonTapped(_ passwordView: PasswordView) {
        brute.stoppedBruteForce = true
        passwordView.passwordProgress.isHidden = true
        passwordView.passwordProgress.stopAnimating()
    }
    
    func resetButtonTapped(_ passwordView: PasswordView) {
        passwordView.isBlackBGColor()
        passwordView.passwordLabel.text = ""
        passwordView.passwordTextField.text = ""
        passwordView.passwordTextField.isSecureTextEntry = true
        stopButtonTapped(passwordView)
        brute.stoppedBruteForce = false
    }
    
    func changeBGColorButtonTapped(_ passwordView: PasswordView) {
        passwordView.isBlack.toggle()
    }
}
