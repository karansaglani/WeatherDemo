//
//  ModelSys.swift
//
//  Created by Karan Saglani on 05/09/20
//  Copyright (c) Karan. All rights reserved.
//

import Foundation

struct ModelSys: Codable {

  enum CodingKeys: String, CodingKey {
    case country
    case sunset
    case id
    case sunrise
    case type
  }

  var country: String?
  var sunset: Int?
  var id: Int?
  var sunrise: Int?
  var type: Int?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    country = try container.decodeIfPresent(String.self, forKey: .country)
    sunset = try container.decodeIfPresent(Int.self, forKey: .sunset)
    id = try container.decodeIfPresent(Int.self, forKey: .id)
    sunrise = try container.decodeIfPresent(Int.self, forKey: .sunrise)
    type = try container.decodeIfPresent(Int.self, forKey: .type)
  }

}
