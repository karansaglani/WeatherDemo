//
//  ModelClouds.swift
//
//  Created by Karan Saglani on 05/09/20
//  Copyright (c) Karan. All rights reserved.
//

import Foundation

struct ModelClouds: Codable {

  enum CodingKeys: String, CodingKey {
    case all
  }

  var all: Int?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    all = try container.decodeIfPresent(Int.self, forKey: .all)
  }

}
