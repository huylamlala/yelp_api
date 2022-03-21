//
//  BusinessServices.swift
//  YelpApi
//
//  Created by Huy Lam on 21/03/2022.
//

import Foundation
import RxSwift

protocol BusinessService {
  func getBusiness(requestModel: BusinessRequestModel) -> Observable<Result<BusinessResponseModel, APIError>>
}

struct BusinessServiceImp: BusinessService {
  var clientRequest = APIRequest()

  func getBusiness(requestModel: BusinessRequestModel) -> Observable<Result<BusinessResponseModel, APIError>> {
    clientRequest.requestObject(route: BusinessURLRequests.getBusiness(requestModel: requestModel))
  }
}
