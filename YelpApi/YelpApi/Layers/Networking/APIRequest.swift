//
//  APIRequest.swift
//  TinderLike
//
//  Created by HuyLH3 on 9/9/20.
//  Copyright © 2020 HuyLH3. All rights reserved.
//

import RxSwift
import Alamofire

class APIRequest {
  private var sessionManager: Alamofire.Session
  
  init() {
    let configuration = URLSessionConfiguration.default
    
    sessionManager = Alamofire.Session(configuration: configuration)
  }
  
  deinit {
    sessionManager.session.invalidateAndCancel()
  }
  
  func requestObject<DecodableType: Decodable>(
    route: URLRequestConvertible
  )  -> Observable<Result<DecodableType, APIError>> {
    return Observable.create { [weak self] (observable) in
      self?.sessionManager
        .request(route)
        .responseDecodable { (response: AFDataResponse<DecodableType>) in
          switch response.result {
          case .success(let object):
            observable.onNext(.success(object))
          case .failure(let error):
            observable.onNext(.failure(.custom(message: error.localizedDescription)))
          }
        }
      return Disposables.create()
    }
  }
}
