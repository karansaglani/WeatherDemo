//
//  ModelMain.swift
//
//  Created by Karan Saglani on 05/09/20
//  Copyright (c) Karan. All rights reserved.
//

import Foundation

struct ModelMain: Codable {

  enum CodingKeys: String, CodingKey {
    case tempMax = "temp_max"
    case humidity
    case pressure
    case feelsLike = "feels_like"
    case tempMin = "temp_min"
    case temp
  }

  var tempMax: Double?
  var humidity: Int?
  var pressure: Int?
  var feelsLike: Double?
  var tempMin: Double?
  var temp: Double?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    tempMax = try container.decodeIfPresent(Double.self, forKey: .tempMax)
    humidity = try container.decodeIfPresent(Int.self, forKey: .humidity)
    pressure = try container.decodeIfPresent(Int.self, forKey: .pressure)
    feelsLike = try container.decodeIfPresent(Double.self, forKey: .feelsLike)
    tempMin = try container.decodeIfPresent(Double.self, forKey: .tempMin)
    temp = try container.decodeIfPresent(Double.self, forKey: .temp)
  }

}
