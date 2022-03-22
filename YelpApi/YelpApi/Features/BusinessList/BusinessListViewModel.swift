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
    case loaded(canLoadMore: Bool)
    case error(APIError)
  }
  
  var state = BehaviorSubject<ViewStates>(value: .initial)
  var businessList: [Business] = []
  var currentRequetModel = BusinessRequestModel()
  var businessService: BusinessService!
  private let disposeBag = DisposeBag()
  
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
    state.onNext(.loaded(canLoadMore: true))
  }
  
  func onRefresh() {
    businessList.removeAll()
    currentRequetModel.offset = businessList.count
    getBusiness()
  }
  
  private func getBusiness() {
    if (try? state.value()) == .loading { return }
    state.onNext(.loading)
    businessService
      .getBusiness(requestModel: currentRequetModel)
      .subscribe(onNext: { [weak self] result in
        guard let strongSelf = self else { return }
        switch result {
        case .failure(let error):
          strongSelf.state.onNext(.error(error))
        case .success(let object):
          strongSelf.businessList.append(contentsOf: object.businesses)
          strongSelf.state.onNext(.loaded(canLoadMore: object.total > strongSelf.businessList.count))
        }
      })
      .disposed(by: disposeBag)
  }
}
