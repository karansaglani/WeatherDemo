//
//  ModelWeather.swift
//
//  Created by Karan Saglani on 05/09/20
//  Copyright (c) Karan. All rights reserved.
//

import Foundation

struct ModelWeather: Codable {

  enum CodingKeys: String, CodingKey {
    case id
    case icon
    case descriptionValue = "description"
    case main
  }

  var id: Int?
  var icon: String?
  var descriptionValue: String?
  var main: String?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    id = try container.decodeIfPresent(Int.self, forKey: .id)
    icon = try container.decodeIfPresent(String.self, forKey: .icon)
    descriptionValue = try container.decodeIfPresent(String.self, forKey: .descriptionValue)
    main = try container.decodeIfPresent(String.self, forKey: .main)
  }

}
