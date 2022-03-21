//
//  Encodable+Extensions.swift
//  YelpApi
//
//  Created by Huy Lam on 21/03/2022.
//

import Foundation

extension Encodable {
  var asJson: [String: Any]? {
    let jsonEncoder = JSONEncoder()
    jsonEncoder.outputFormatting = .prettyPrinted
    do {
      let jsonData = try jsonEncoder.encode(self)
      return try JSONSerialization.jsonObject(with: jsonData, options : .allowFragments) as? [String: Any]
    } catch {
      return nil
    }
  }
}
