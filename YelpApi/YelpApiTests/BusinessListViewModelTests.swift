//
//  BusinessListViewModelTests.swift
//  YelpApiTests
//
//  Created by Huy Lam on 21/03/2022.
//

import XCTest
@testable import YelpApi
import Mockingbird
import RxSwift

class BusinessListViewModelTests: XCTestCase {
  var viewModel: BusinessListViewModel!
  var businessServiceMock: BusinessServiceMock!
  
  override func setUpWithError() throws {
    viewModel = BusinessListViewModel()
    businessServiceMock = mock(BusinessService.self)
    viewModel.businessService = businessServiceMock
  }
  
  func testOnFilterChanged() throws {
    //give
    let requestModel = BusinessRequestModel(
      newSearchTerm: "new search term",
      newCategory: .all,
      newLocation: nil,
      newSorting: .distance
    )
    given(businessServiceMock.getBusiness(requestModel: requestModel)).will { _ in
      Observable.create { observable in
        observable.onNext(.success(.draftModel))
        return Disposables.create()
      }
    }
    // when filter change
    // it should update, then get business list
    viewModel.onFilterChanged(newSearchTerm: "new search term",
                              newCategory: .all,
                              newLocation: nil,
                              newSorting: .distance)
    verify(businessServiceMock.getBusiness(requestModel: requestModel)).wasCalled()
    XCTAssert(viewModel.businessList == [Business.draftModel])
    XCTAssert((try? viewModel.state.value()) == .loaded(canLoadMore: true))
  }
  
  func testOnLoadMore() throws {
    //give
    given(businessServiceMock.getBusiness(requestModel: viewModel.currentRequetModel)).will { _ in
      Observable.create { observable in
        observable.onNext(.success(.draftModel))
        return Disposables.create()
      }
    }
    viewModel.onLoadmore()
    verify(businessServiceMock.getBusiness(requestModel: viewModel.currentRequetModel)).wasCalled()
    XCTAssert(viewModel.businessList == [Business.draftModel])
    XCTAssert((try? viewModel.state.value()) == .loaded(canLoadMore: true))
  }
  
  func testOnTapErrorCta() throws {
    viewModel.onTapErrorCta()
  }
  
  func testOnRefresh() throws {
    //give
    given(businessServiceMock.getBusiness(requestModel: viewModel.currentRequetModel)).will { _ in
      Observable.create { observable in
        observable.onNext(.success(.draftModel))
        return Disposables.create()
      }
    }
    viewModel.onRefresh()
    verify(businessServiceMock.getBusiness(requestModel: any())).wasCalled()
    XCTAssert(viewModel.businessList == [Business.draftModel])
    XCTAssert((try? viewModel.state.value()) == .loaded(canLoadMore: true))
  }
}
