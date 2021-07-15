//
//  Auth.swift
//  Toolbox
//
//  Created by Ali Gutierrez on 7/12/21.
//

import Foundation
import SwiftUI

enum Authenticator {
    /// Log in using Toolbox Service.
    ///
    /// - Parameters:
    ///   - loginParameters: Login Parameters
    ///   - completion: closure for completion
    static func login(loginParameters: LoginParameters? = nil,
               completion: @escaping (ToolboxUser?, Error?) -> Void) {
        
        guard let loginParameters = loginParameters else { return }
        
        serviceLocator
            .webService
            .login(loginParameters, errorType: LoginError.self)
            .execute(onSuccess: { toolboxUser in
                
                serviceLocator
                    .userDefaults
                    .set(toolboxUser.token, forKey: .token)
                
                serviceLocator
                    .userDefaults
                    .set(toolboxUser.type, forKey: .type)
                
                serviceLocator
                    .userDefaults
                    .set(true, forKey: .isSessionActive)
                
                
                
                completion(toolboxUser, nil)
            }, onFailure: { error in
                completion(nil, error)
            })
    }
}
