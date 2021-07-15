//
//  LoginViewModel.swift
//  Toolbox
//
//  Created by Ali Gutierrez on 7/12/21.
//

import SwiftUI
import Combine

class LoginViewModel: ObservableObject, Identifiable {
    
    @Published var parameters = LoginParameters()
    @Published var needsAuthentication: Bool
    @Published var isAuthenticating: Bool
    @Published var isLoggedIn: Bool
    
    init() {
        self.needsAuthentication = serviceLocator.userDefaults.string(forKey: .token) == nil
        self.isLoggedIn = false
        self.isAuthenticating = false
    }
    
    
    var selectedEnvironment: BackendEnvironment {
        guard let backend = BackendEnvironment.current else {
            return BackendEnvironment.dev
        }
        return backend
    }
    
    var currentEnvironmentIndex: Int {
        return BackendEnvironment.allCases.firstIndex(of: selectedEnvironment) ?? 0
    }
    
    // MARK: - Setters
    
    @discardableResult
    func setSub(_ sub: String) -> LoginError? {
        guard !sub.isEmpty else { return LoginError.sub }
        self.parameters.sub = sub
        return nil
    }
    
    func setSubDomain(_ domain: BackendEnvironment) throws {
        guard let url = domain.url else { throw LoginError.invalidSubDomain }
        self.setBaseURL(url)
    }
    
    func setSubDomain(_ domain: String) -> LoginError? {
        guard
            !domain.isEmpty,
            let url = BackendEnvironment.buildCustomURL(domain) else { return LoginError.invalidSubDomain }
        setBaseURL(url)
        return nil
    }
    
    private func setBaseURL(_ url: URL) {
        BackendEnvironment.baseURL = url
    }
    
    // MARK: - Actions
    
    private func executeLogin(completion: @escaping (ToolboxUser?, Error?) -> Void) {
        dispatchAsyncInMainQueue { [weak self] in
            guard let self = self else { return }
            let parameters = self.parameters
            
            Authenticator.login(loginParameters: parameters, completion: { completion($0, $1) })
        }
    }
    
    func doLogin(completion: @escaping (ToolboxUser?, Error?) -> Void) {
        guard !self.parameters.sub.isEmpty else { return completion(nil, LoginError.username) }
        
        executeLogin(completion: completion)
    }
}

