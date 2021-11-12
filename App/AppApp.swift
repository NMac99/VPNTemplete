//
//  AppApp.swift
//  App
//
//  Created by Narek Arsenyan on 15.10.21.
//

import SwiftUI

@main
struct AppApp: App {
    var body: some Scene {
        WindowGroup {
//            isAgreementChecked() ? AnyView(IntroVWOne()) : AnyView(IntroVW())
            IntroVW()
        }
    }
}

func isAgreementChecked() -> Bool {
    let defaults = UserDefaults.standard
    if let checked = defaults.string(forKey: defaultsKeys.keyAgreement) {
        return true
    }
    return false
}
