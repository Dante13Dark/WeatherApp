//
//  WeatherForecast.swift
//  Weather
//
//  Created by Yaroslav Tutushkin on 25.02.2020.
//  Copyright © 2020 Yaroslav Tutushkin. All rights reserved.
//

import Foundation


struct WeatherForecast: Decodable, Equatable {
	var cod: String?
	var message: Int?
	var cnt: Int?
	var list: [List]
	var city: City

	private enum CodingKeys: String, CodingKey {
		case cod
		case message
		case cnt
		case list
		case city
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		cod = try container.decode(String.self, forKey: .cod)
		message = try container.decode(Int.self, forKey: .message)
		cnt = try container.decode(Int.self, forKey: .cnt)
		list = try container.decode([List].self, forKey: .list)
		city = try container.decode(City.self, forKey: .city)
	}
}

struct List: Decodable, Equatable {

	var dt: Int
	var main: MainClass
	var weather: [Weather]
	var clouds: Clouds
	var wind: Wind
	var sys: ForeSys?
	var dt_txt: String?

	private enum CodingKeys: String, CodingKey {
		case dt
		case main
		case weather
		case clouds
		case wind
		case sys
		case dt_txt = "dt_txt"
	}
}


struct MainClass: Decodable, Equatable {
	var temp: Double
	var tempMin: Double
	var tempMax: Double
	var pressure: Int
	var sea_level: Int?
	var grnd_level: Int?
	var humidity: Int
	var temp_kf: Double?

	private enum CodingKeys: String, CodingKey {
		case temp = "temp"
		case tempMin = "temp_min"
		case tempMax = "temp_max"
		case pressure = "pressure"
		case sea_level = "sea_level"
		case grnd_level = "grnd_level"
		case humidity = "humidity"
		case temp_kf = "temp_kf"
	}
}

struct Rain: Decodable, Equatable {
	var threeH: Double?

	private enum CodingKeys: String, CodingKey {
		case threeH = "3h"
	}

}

struct ForecastSys: Decodable, Equatable {
	var sys: String?

	private enum CodingKeys: String, CodingKey {
		case sys
	}
}

struct ForeSys: Decodable, Equatable {
	var pod: String?

	private enum CodingKeys: String, CodingKey {
		case pod
	}
}

