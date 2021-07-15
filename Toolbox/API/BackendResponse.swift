//
//  BackendResponse.swift
//  Toolbox
//
//  Created by Ali Gutierrez on 7/9/21.
//

import Foundation

// Type to be used for all enums that represent an error from Backend
typealias ToolboxError = Error & LocalizedError & Decodable

/// Structure for a custom Mitwerken backend response.
struct BackendResponse<T> where T: ToolboxError {
    let error: ToolboxAPIError?
}

struct ToolboxAPIError: Codable {
    let message: String
    let code: String
}

// MARK: - MitwerkenError
extension BackendResponse: ToolboxError {
    // MARK: LocalizedError

    // MARK: Decodable

    enum CodingKeys: CodingKey {
        case error
    }

    /// Custom implementation for decoder to support T and custom errors from AWS.
    ///
    /// - Parameter decoder: a decoder.
    /// - Throws: When a container does not contain one of the CodingKeys.
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let error = try? container.decode(ToolboxAPIError.self, forKey: .error)
        self.init(error: error)
    }
}
