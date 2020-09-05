//
//  ModelWind.swift
//
//  Created by Karan Saglani on 05/09/20
//  Copyright (c) Karan. All rights reserved.
//

import Foundation

struct ModelWind: Codable {

  enum CodingKeys: String, CodingKey {
    case speed
    case deg
  }

  var speed: Double?
  var deg: Int?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    speed = try container.decodeIfPresent(Double.self, forKey: .speed)
    deg = try container.decodeIfPresent(Int.self, forKey: .deg)
  }

}
