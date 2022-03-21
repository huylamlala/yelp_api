//
//  BusinessURLRequests.swift
//  YelpApi
//
//  Created by Huy Lam on 21/03/2022.
//


import Alamofire

enum BusinessURLRequests: RouterURLRequestConvertible, Equatable {
  
  case getBusiness(requestModel: BusinessRequestModel)
    
    var method: HTTPMethod {
        switch self {
        case .getBusiness:
            return .get
        }
    }
    
    var path: String {
        return "businesses/search"
    }
    
    var parameters: Parameters? {
        switch self {
        case .getBusiness(let requestModel):
          return requestModel.asJson
        }
    }
}
