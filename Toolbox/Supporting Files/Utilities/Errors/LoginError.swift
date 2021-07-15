//
//  LoginError.swift
//  Toolbox
//
//  Created by Ali Gutierrez on 7/12/21.
//

import Foundation

public enum LoginError: String, ToolboxError {
    case username = "MISSING_USERNAME"
    case sub = "SUB_NOT_FOUND"
    
    // In-app errors
    case invalidSubDomain
}

public extension LoginError {
        
    var errorDescription: String? {
        switch self {
        case .username:
            return "Please provide valid username"
        case .sub:
            return "We couldn't find an account with that username"
        case .invalidSubDomain:
            return "Please provide a valid URL"
        }
    }
}

// MARK: - CaseIterable
extension LoginError: CaseIterable {

    /// Failable init from a localized description.
    ///
    /// - Parameter description: Exact localized description for the case.
    init?(description: String) {
        guard let value = LoginError.allCases.first(where: { $0.errorDescription == description }) else { return nil }
        self = value
    }
}
