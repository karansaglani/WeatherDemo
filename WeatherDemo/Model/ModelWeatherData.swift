//
//  ModelWeatherData.swift
//
//  Created by Karan Saglani on 05/09/20
//  Copyright (c) Karan. All rights reserved.
//

import Foundation

struct ModelWeatherData: Codable {

  enum CodingKeys: String, CodingKey {
    case wind
    case base
    case name
    case id
    case dt
    case clouds
    case weather
    case main
    case coord
    case cod
    case sys
    case visibility
    case timezone
  }

  var wind: ModelWind?
  var base: String?
  var name: String?
  var id: Int?
  var dt: Int?
  var clouds: ModelClouds?
  var weather: [ModelWeather]?
  var main: ModelMain?
  var coord: ModelCoord?
  var cod: Int?
  var sys: ModelSys?
  var visibility: Int?
  var timezone: Int?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    wind = try container.decodeIfPresent(ModelWind.self, forKey: .wind)
    base = try container.decodeIfPresent(String.self, forKey: .base)
    name = try container.decodeIfPresent(String.self, forKey: .name)
    id = try container.decodeIfPresent(Int.self, forKey: .id)
    dt = try container.decodeIfPresent(Int.self, forKey: .dt)
    clouds = try container.decodeIfPresent(ModelClouds.self, forKey: .clouds)
    weather = try container.decodeIfPresent([ModelWeather].self, forKey: .weather)
    main = try container.decodeIfPresent(ModelMain.self, forKey: .main)
    coord = try container.decodeIfPresent(ModelCoord.self, forKey: .coord)
    cod = try container.decodeIfPresent(Int.self, forKey: .cod)
    sys = try container.decodeIfPresent(ModelSys.self, forKey: .sys)
    visibility = try container.decodeIfPresent(Int.self, forKey: .visibility)
    timezone = try container.decodeIfPresent(Int.self, forKey: .timezone)
  }

}
