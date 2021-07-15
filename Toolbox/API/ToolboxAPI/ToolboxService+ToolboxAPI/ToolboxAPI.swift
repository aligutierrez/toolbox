//
//  ToolboxAPI.swift
//  Toolbox
//
//  Created by Ali Gutierrez on 7/12/21.
//

import Foundation
import PromisedFuture

typealias ToolboxAPI = ToolboxLoginAPI


protocol ToolboxLoginAPI {
    func login<T>(_ params: LoginParameters,
                  errorType: T.Type) -> Future<ToolboxUser> where T: ToolboxError
    
    func getData<T>(errorType: T.Type) -> Future<[MoviesCarousel]> where T: ToolboxError
}

extension ToolboxService: ToolboxLoginAPI {
    func login<T>(_ params: LoginParameters,
                  errorType: T.Type) -> Future<ToolboxUser> where T : ToolboxError {
        performRequest(route: ToolboxRouter.login(params), errorType: T.self)
    }
    
    func getData<T>(errorType: T.Type) -> Future<[MoviesCarousel]> where T : ToolboxError {
        performRequest(route: ToolboxRouter.carousel, errorType: T.self)
    }
}
