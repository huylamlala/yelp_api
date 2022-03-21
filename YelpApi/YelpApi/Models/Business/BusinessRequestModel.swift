//
//  BusinessRequestModel.swift
//  YelpApi
//
//  Created by Huy Lam on 21/03/2022.
//

import Foundation

struct BusinessRequestModel: Codable, Equatable {
  
  let term: String?
  let location: String
  let category: CategoryFilter
  let sortBy: RequestSorting?
  var offset: Int
  
  init() {
    term = nil
    location = "Singapore"
    offset = 0
    sortBy = nil
    category = .all
  }
  
  init(
    newSearchTerm: String?,
    newCategory: CategoryFilter,
    newLocation: String?,
    newSorting: RequestSorting?
  ) {
    term = newSearchTerm
    category = newCategory
    location = (newLocation ?? "").isEmpty ? "Singapore" : newLocation!
    sortBy = newSorting
    offset = 0
  }
  
  private enum CodingKeys: String, CodingKey {
    case sortBy = "sort_by"
    case category = "categories"
    case term, location, offset
  }
}

enum CategoryFilter: String, Codable {
  case football, surfing, snorkeling, seniorcenters, all
}

enum RequestSorting: String, Codable {
  case rating, distance
}
