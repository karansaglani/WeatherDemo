//
//  ModelCoord.swift
//
//  Created by Karan Saglani on 05/09/20
//  Copyright (c) Karan. All rights reserved.
//

import Foundation

struct ModelCoord: Codable {

  enum CodingKeys: String, CodingKey {
    case lon
    case lat
  }

  var lon: Double?
  var lat: Double?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    lon = try container.decodeIfPresent(Double.self, forKey: .lon)
    lat = try container.decodeIfPresent(Double.self, forKey: .lat)
  }

}
