//
//  BusinessListViewModel.swift
//  YelpApi
//
//  Created by Huy Lam on 21/03/2022.
//

import Foundation
import RxSwift

class BusinessListViewModel {
  enum ViewStates: Equatable {
    case initial
    case loading
    case loaded
    case error(APIError)
  }
  
  var state = BehaviorSubject<ViewStates>(value: .initial)
  var businessList: [Business] = []
  var currentRequetModel = BusinessRequestModel()
  var businessService: BusinessService!
  
  func onFilterChanged(newSearchTerm: String?,
                       newCategory: CategoryFilter,
                       newLocation: String?,
                       newSorting: RequestSorting?) {
    businessList.removeAll()
    currentRequetModel = BusinessRequestModel(newSearchTerm: newSearchTerm,
                                              newCategory: newCategory,
                                              newLocation: newLocation,
                                              newSorting: newSorting)
    getBusiness()
  }
  
  func onLoadmore() {
    currentRequetModel.offset = businessList.count
    getBusiness()
  }
  
  func onTapErrorCta() {
    state.onNext(.loaded)
  }
  
  func onRefresh() {
    businessList.removeAll()
    currentRequetModel.offset = businessList.count
    getBusiness()
  }
  
  private func getBusiness() {
    state.onNext(.loading)
    businessService
      .getBusiness(requestModel: currentRequetModel)
      .subscribe(onNext: { [weak self] result in
        switch result {
        case .failure(let error):
          self?.state.onNext(.error(error))
        case .success(let object):
          self?.businessList.append(contentsOf: object.businesses)
          self?.state.onNext(.loaded)
        }
      })
      .dispose()
  }
}
