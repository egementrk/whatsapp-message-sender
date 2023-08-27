//
//  MainViewModel.swift
//  WhatsappMessage
//
//  Created by Egemen Türk on 27.08.2023.
//

import Foundation

public protocol MainViewDataSource: AnyObject {
    
}

public protocol MainViewEventSource: AnyObject {
    func didPressedSendButton(countryCode: String, phoneNumber: String, message: String)
    
    var didCreateURL: ((NSURL) -> Void)? { get set }
}

public protocol MainViewProtocol: MainViewDataSource, MainViewEventSource {
    
}

public final class MainViewModel: MainViewProtocol {
    
    //EventSource
    public var didCreateURL: ((NSURL) -> Void)?
    
    //    private var whatsApiUrl = "https://api.whatsapp.com/send?="
    private let whatsApiUrl = "https://wa.me/"
}

extension MainViewModel {
    
    public func didPressedSendButton(countryCode: String, phoneNumber: String, message: String) {
        let targetURL = whatsApiUrl + countryCode + phoneNumber + "?text=" + message
        let urlStringEncoded = targetURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        guard let urlStringEncoded else { return }
        let URL = NSURL(string: urlStringEncoded)
        guard let URL else { return }
        didCreateURL?(URL)
    }
}
