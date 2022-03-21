//
//  FilterViewModel.swift
//  YelpApi
//
//  Created by Huy Lam on 21/03/2022.
//

import Foundation
import RxSwift

class FilterViewModel {
  var searchTerm = BehaviorSubject<String?>(value: nil)
  var location = BehaviorSubject<String>(value: "")
  var sorting = BehaviorSubject<RequestSorting?>(value: nil)
  var category = BehaviorSubject<CategoryFilter>(value: .all)

  
  func onSearchTermChanged(_ newValue: String) {
    searchTerm.onNext(newValue)
  }
  
  func onLocationChanged(_ newValue: String) {
    location.onNext(newValue)
  }
  
  func onSortingChanged(_ newValue: RequestSorting?) {
    sorting.onNext(newValue)
  }
  
  func onCategoryChanged(_ newValue: CategoryFilter) {
    category.onNext(newValue)
  }
}
