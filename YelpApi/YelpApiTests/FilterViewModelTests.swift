//
//  FilterViewModelTests.swift
//  YelpApiTests
//
//  Created by Huy Lam on 21/03/2022.
//

import XCTest
@testable import YelpApi
import Mockingbird
import RxSwift

class FilterViewModelTests: XCTestCase {
  var viewModel: FilterViewModel!
  override func setUpWithError() throws {
    viewModel = FilterViewModel()
  }
  
  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  func testOnSearchTermChanged() throws {
    let newValue = "some thing new"
    viewModel.onSearchTermChanged(newValue)
    XCTAssert((try? viewModel.searchTerm.value()) == newValue)
  }
  
  func testOnLocationChanged() throws {
    let newValue = "some thing new"
    viewModel.onLocationChanged(newValue)
    XCTAssert((try? viewModel.location.value()) == newValue)
  }
  
  
  func testOnSortingChanged() throws {
    let newValue: RequestSorting = .rating
    viewModel.onSortingChanged(newValue)
    XCTAssert((try? viewModel.sorting.value()) == newValue)
  }
  
  
  func testOnCategoryChanged() throws {
    let newValue: CategoryFilter = .football
    viewModel.onCategoryChanged(newValue)
    XCTAssert((try? viewModel.category.value()) == newValue)
  }
}
