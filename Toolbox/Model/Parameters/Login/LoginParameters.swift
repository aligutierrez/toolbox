//
//  LoginParameters.swift
//  Toolbox
//
//  Created by Ali Gutierrez on 7/12/21.
//

import Foundation

struct LoginParameters {

    
    // Properties

    var sub: String

    /// Inits a LoginParameters object with default values
    ///
    init() {
        sub = ""
    }
}

// MARK: - Encodable
extension LoginParameters: Encodable {
    enum CodingKeys: String, CodingKey {
        case sub
    }

}

// MARK: - Equatable
extension LoginParameters: Equatable {

    /// Equatable conformance
    ///
    /// - Parameters:
    ///   - lhs: left hand side of == operator
    ///   - rhs: right hand side of == operator
    /// - Returns: bool indicating if both objects are considered equal.
    static func == (lhs: LoginParameters, rhs: LoginParameters) -> Bool {
        return
            lhs.sub == rhs.sub
    }
}
