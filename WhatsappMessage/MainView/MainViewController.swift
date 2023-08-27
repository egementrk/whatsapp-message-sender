//
//  MainViewController.swift
//  WhatsappMessage
//
//  Created by Egemen Türk on 27.08.2023.
//

import UIKit
import MobilliumBuilders
import TinyConstraints

final class MainViewController: UIViewController {
    
    private let textFieldStackView = UIStackViewBuilder()
        .axis(.horizontal)
        .spacing(4)
        .build()
    
    private let countryCodeTextField = UITextFieldBuilder()
        .placeholder("Country Code")
        .textColor(.blue)
        .textAlignment(.center)
        .cornerRadius(12)
        .backgroundColor(.systemGray6)
        .build()
    
    private let phoneNumberTextField = UITextFieldBuilder()
        .placeholder("Phone Number")
        .textColor(.black)
        .textAlignment(.center)
        .cornerRadius(12)
        .backgroundColor(.systemGray6)
        .build()
    
    private let messageTextField = UITextFieldBuilder()
        .placeholder("Message")
        .textColor(.black)
        .textAlignment(.center)
        .cornerRadius(12)
        .backgroundColor(.systemGray6)
        .build()

    private let sendMessageButton = UIButtonBuilder()
        .title("Send Message")
        .cornerRadius(12)
        .titleColor(.white)
        .backgroundColor(.systemBlue)
        .build()
    
    private let viewModel = MainViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviews()
        configureContents()
        subscribeViewModel()
    }
}

// MARK: - UILayout
extension MainViewController {
    
    private func addSubviews() {
        addTextFieldStackView()
        addMessageTextField()
        addSendMessageButton()
    }
    
    private func addTextFieldStackView() {
        view.addSubview(textFieldStackView)
        textFieldStackView.addArrangedSubview(countryCodeTextField)
        textFieldStackView.addArrangedSubview(phoneNumberTextField)
        textFieldStackView.centerYToSuperview()
        textFieldStackView.centerXToSuperview()
    }
    
    private func addMessageTextField() {
        view.addSubview(messageTextField)
        messageTextField.topToBottom(of: textFieldStackView, offset: 4)
        messageTextField.centerXToSuperview()
    }
    
    private func addSendMessageButton() {
        view.addSubview(sendMessageButton)
        sendMessageButton.topToBottom(of: messageTextField, offset: 12)
        sendMessageButton.centerXToSuperview()
    }
}

// MARK: - ConfigureContents
extension MainViewController {
    
    private func configureContents() {
        configureCountryCodeTextField()
        configureMessageTextField()
        configurePhoneNumberTextField()
        configureSendMessageButton()
    }
    
    private func configureCountryCodeTextField() {
        countryCodeTextField.size(CGSize(width: 150, height: 50))
        countryCodeTextField.keyboardType = .numberPad
    }
    
    private func configurePhoneNumberTextField() {
        phoneNumberTextField.size(CGSize(width: 200, height: 50))
        phoneNumberTextField.keyboardType = .numberPad
    }
    
    private func configureMessageTextField() {
        messageTextField.size(to: phoneNumberTextField)
    }
    
    private func configureSendMessageButton() {
        sendMessageButton.height(50)
        sendMessageButton.width(300)
        sendMessageButton.addTarget(self, action: #selector(didPressedSendButton), for: .touchUpInside)
    }
}

// MARK: - SubscribeViewModel
extension MainViewController {
    
    private func subscribeViewModel() {
        viewModel.didCreateURL = { url in
            if UIApplication.shared.canOpenURL(url as URL) {
                UIApplication.shared.open(url as URL)
            }
        }
    }
}

// MARK: - Actions
extension MainViewController {
    
    @objc
    private func didPressedSendButton() {
        guard let countryCode = countryCodeTextField.text else { return}
        guard let phoneNumber = phoneNumberTextField.text else { return }
        guard let message = messageTextField.text else { return }
        viewModel.didPressedSendButton(countryCode: countryCode, phoneNumber: phoneNumber, message: message)
    }
}

extension MainViewController {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        countryCodeTextField.resignFirstResponder()
        phoneNumberTextField.resignFirstResponder()
        messageTextField.resignFirstResponder()
    }
}
