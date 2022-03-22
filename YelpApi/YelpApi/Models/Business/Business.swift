//
//  Business.swift
//  YelpApi
//
//  Created by Huy Lam on 21/03/2022.
//

import Foundation

// MARK: - Business

struct Business {
  let rating: Double?
  let price, phone, id, alias: String?
  let isClosed: Bool?
  let categories: [Category]?
  let reviewCount: Int?
  let name: String?
  let url: String?
  let coordinates: Center?
  let imageURL: String?
  let location: Location?
  let distance: Double?
  let transactions: [String]?
}

extension Business: Codable, Equatable {
  static func == (lhs: Business, rhs: Business) -> Bool {
    rhs.id == lhs.id
  }
  
  enum CodingKeys: String, CodingKey {
    case rating, price, phone, id, alias
    case isClosed = "is_closed"
    case categories
    case reviewCount = "review_count"
    case name, url, coordinates
    case imageURL = "image_url"
    case location, distance, transactions
  }
  
  static var draftModel: Business {
    Business(rating: 4,
             price: "$",
             phone: "+14152520800",
             id: "E8RJkjfdcwgtyoPMjQ_Olg",
             alias: "four-barrel-coffee-san-francisco",
             isClosed: false,
             categories: [Category(alias: "coffee", title: "Coffee & Tea")],
             reviewCount: 1738, name: "Four Barrel Coffee",
             url: "https://www.yelp.com/biz/four-barrel-coffee-san-francisco",
             coordinates: Center(latitude: 37.7670169511878, longitude: -122.42184275),
             imageURL: "http://s3-media2.fl.yelpcdn.com/bphoto/MmgtASP3l_t4tPCL1iAsCg/o.jpg",
             location: Location(city: "San Francisco",
                                country: "US",
                                address2: "",
                                address3: "",
                                state: "CA",
                                address1: "375 Valencia St",
                                zipCode: "94103"),
             distance: 1604.23,
             transactions: ["pickup", "delivery"])
  }
}


// MARK: - Category
struct Category: Codable {
  let alias, title: String?
}

// MARK: - Center
struct Center: Codable, Equatable {
  let latitude, longitude: Double?
}

// MARK: - Location
struct Location: Codable {
  let city, country, address2, address3: String?
  let state, address1, zipCode: String?
  
  enum CodingKeys: String, CodingKey {
    case city, country, address2, address3, state, address1
    case zipCode = "zip_code"
  }
}
// MARK: - Region
struct Region: Codable, Equatable {
  let center: Center?
}

