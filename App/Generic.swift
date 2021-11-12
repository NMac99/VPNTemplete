//
//  Generic.swift
//  App
//
//  Created by Narek Arsenyan on 19.10.21.
//

import Foundation
import UIKit

struct defaultsKeys {
    static let keyAgreement = "AgreementChecked"
}

struct ScreenSize {
    static let screenHeight = UIScreen.main.bounds.size.height
    
}

extension Notification.Name {
    static let notificationOne = Notification.Name("notificationOne")
    static let notificationTwo = Notification.Name("notificationTwo")
}

