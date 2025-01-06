    //
    //  LocalaKeys.swift
    //  VbSnackOverFlow
    //
    //  Created by oguzhan on 2.09.2024.
    //

import Foundation

protocol Localizable: RawRepresentable where RawValue == String {
    var localized: String { get }
    func localized(with arguments: CVarArg...) -> String
}

enum LocaleKeys: String, Localizable {
    case createAccount = "Create account"
    case backToLogin = "Back to login"
    case age = "Age"

}

extension Localizable {
    /// Localized your key
    var localized: String {
        NSLocalizedString(rawValue, comment: "")
    }

    /// Localized your key
    /// - Parameter arguments: <#arguments
    /// - Returns: Value with params
    func localized(with arguments: CVarArg...) -> String {
        String(format: localized, arguments)
    }
}
