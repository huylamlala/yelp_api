//
//  BusinessResponseModel.swift
//  YelpApi
//
//  Created by Huy Lam on 21/03/2022.
//

import Foundation

// MARK: - BusinessResponseModel
struct BusinessResponseModel: Codable, Equatable {
    let total: Int
    let businesses: [Business]
    let region: Region
  
  static let draftModel: Self = Self(
    total: 8228,
    businesses: [.draftModel],
    region: Region(center: Center(latitude: 37.767413217936834,
                                  longitude: -122.42820739746094))
  )
}

