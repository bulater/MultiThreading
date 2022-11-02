//
//  PasswordView.swift
//  MultiThreading
//
//  Created by Илья Белкин on 02.11.2022.
//

import UIKit

protocol PasswordViewDelegate {
    func startButtonTapped(_ passwordView: PasswordView)
    func stopButtonTapped(_ passwordView: PasswordView)
    func resetButtonTapped(_ passwordView: PasswordView)
    func changeBGColorButtonTapped(_ passwordView: PasswordView)
}

final class PasswordView: UIView {
    
    var delegate: PasswordViewDelegate?
    
    var isBlack: Bool = false {
        didSet {
            isBlackBGColor()
        }
    }
    
    lazy var passwordLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 25)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .systemGray6
        textField.placeholder = "Enter Password"
        textField.isSecureTextEntry = true
        textField.borderStyle = .roundedRect
        textField.returnKeyType = .done
        return textField
    }()
    
     lazy var passwordProgress: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.isHidden = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    lazy var resetButton: UIButton = {
        let button = UIButton()
        button.setTitle("Reset", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.addTarget(self, action: #selector(resetButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var startButton: UIButton = {
        let button = UIButton()
        button.setTitle("Start", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var stopButton: UIButton = {
        let button = UIButton()
        button.setTitle("Stop", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.addTarget(self, action: #selector(stopButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var changeBGColorButton: UIButton = {
        let button = UIButton()
        button.setTitle("Change Color", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.addTarget(self, action: #selector(changeBGColorButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHierarchy()
        setupStackView()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupHierarchy() {
        addSubview(stackView)
        addSubview(passwordProgress)
        stackView.addArrangedSubview(passwordLabel)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(resetButton)
        stackView.addArrangedSubview(startButton)
        stackView.addArrangedSubview(stopButton)
        stackView.addArrangedSubview(changeBGColorButton)
    }
    
    private func setupStackView() {
        stackView.setCustomSpacing(150, after: passwordLabel)
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7),
            
            passwordProgress.centerYAnchor.constraint(equalTo: passwordTextField.centerYAnchor),
            passwordProgress.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor, constant: -10)
        ])
    }
    
    func isBlackBGColor() {
        if isBlack {
            backgroundColor = .black
            self.passwordLabel.textColor = .white
            self.resetButton.setTitleColor(UIColor.white, for: .normal)
            self.startButton.setTitleColor(UIColor.white, for: .normal)
            self.stopButton.setTitleColor(UIColor.white, for: .normal)
            self.changeBGColorButton.setTitleColor(UIColor.white, for: .normal)
        } else {
            backgroundColor = .white
            self.passwordLabel.textColor = .black
            self.resetButton.setTitleColor(UIColor.black, for: .normal)
            self.startButton.setTitleColor(UIColor.black, for: .normal)
            self.stopButton.setTitleColor(UIColor.black, for: .normal)
            self.changeBGColorButton.setTitleColor(UIColor.black, for: .normal)
        }
    }
    
    private func configureView() {
        backgroundColor = .white
    }
}

extension PasswordView: PasswordViewDelegate {
    @objc func startButtonTapped(_ passwordView: PasswordView) {
        delegate?.startButtonTapped(self)
    }
    
    @objc func stopButtonTapped(_ passwordView: PasswordView) {
        delegate?.stopButtonTapped(self)
    }
    
    @objc func resetButtonTapped(_ passwordView: PasswordView) {
        delegate?.resetButtonTapped(self)
    }
    
    @objc func changeBGColorButtonTapped(_ passwordView: PasswordView) {
        delegate?.changeBGColorButtonTapped(self)
    }
}
