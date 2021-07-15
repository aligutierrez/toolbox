//
//  ToolboxRouter.swift
//  Toolbox
//
//  Created by Ali Gutierrez on 7/12/21.
//

import Alamofire
import Foundation

enum ToolboxRouter: APIConfiguration {
    
    case login(Encodable)
    case carousel
    
    
    // MARK: BaseURL
    var baseUrl: URL { BackendEnvironment.baseURL }

    
    // MARK: HTTPMethod

    internal var method: HTTPMethod {
        switch self {
        case .login:
            return .post
        default:
            return .get
        }
    }
    
    
    // MARK: Path

    internal var path: String {
        switch self {
        case .login:
            return "/v1/mobile/auth"
        case .carousel:
            return "/v1/mobile/data"
        }
    }
    
    
    // MARK: Parameters

    internal var parameters: Parameters? {
        switch self {
        case let .login(params):
            return params.asDictionary
        default:
            return nil
        }
    }
    
    internal var customParameters: (contentType: String?, data: Data?)? {
        return nil
    }
    
    
    // MARK: ContentTypes

    var additionalContentTypes: [String] { [] }
}
