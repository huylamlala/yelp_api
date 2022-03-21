//
//  ApiError.swift
//  TinderLike
//
//  Created by HuyLH3 on 9/9/20.
//  Copyright © 2020 HuyLH3. All rights reserved.
//

import Alamofire

public enum APIError: Error, Equatable {
    case custom(message: String)
    
    var localizedDescription: String {
        switch self {
        case .custom(let message): return message
        }
    }
}

