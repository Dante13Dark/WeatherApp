//
//  WeatherForecast.swift
//  Weather
//
//  Created by Yaroslav Tutushkin on 25.02.2020.
//  Copyright © 2020 Yaroslav Tutushkin. All rights reserved.
//

import Foundation


struct WeatherForecast: Decodable {

	var cod: String?
	var message: Int?
	var cnt: Int?
	var list: [List]?
	var city: City?

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

extension WeatherForecast {
	struct City: Decodable {
		var id: Int?
		var name: String?
		var coord: Coordinates?
		var country: String?
		var timezone: Int?
		var sunrise: Int?
		var sunset: Int?

		private enum CodingKeys: String, CodingKey {
			case id
			case name
			case coord
			case country
			case timezone
			case sunrise
			case sunset
		}
	}

	struct Coordinates: Decodable {
		var lat: Double?
		var lon: Double?

		private enum CodingKeys: String, CodingKey {
			case lat
			case lon
		}
	}
}

extension WeatherForecast {
	struct List: Decodable {

		var dt: Int?
		var main: MainClass?
		var weather: [ForeWeather]?
		var clouds: ForeCloud?
		var wind: ForeWind?
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
}

extension WeatherForecast.List {
	struct MainClass: Decodable {
		var temp: Double?
		var temp_min: Double?
		var temp_max: Double?
		var pressure: Int?
		var sea_level: Int?
		var grnd_level: Int?
		var humidity: Int?
		var temp_kf: Double?

		private enum CodingKeys: String, CodingKey {
			case temp        = "temp"
			case temp_min    = "temp_min"
			case temp_max    = "temp_max"
			case pressure    = "pressure"
			case sea_level   = "sea_level"
			case grnd_level  = "grnd_level"
			case humidity    = "humidity"
			case temp_kf     = "temp_kf"
		}
	}

	struct Rain: Decodable{
		var threeH: Double?

		private enum CodingKeys: String, CodingKey {
			case threeH = "3h"
		}

	}

	class ForecastSys: Decodable{
		var sys: String?

		private enum CodingKeys: String, CodingKey {
			case sys
		}
	}

	struct ForeWeather: Decodable{
		var id: Int?
		var main: String?
		var description: String?
		var icon: String?

		private enum CodingKeys: String, CodingKey {
			case id
			case main
			case description
			case icon

		}
	}

	struct ForeCloud: Decodable{
		var all: Int?

		private enum CodingKeys: String, CodingKey {
			case all
		}
	}

	struct ForeWind: Decodable{
		var speed: Double?
		var deg: Int?

		private enum CodingKeys: String, CodingKey {
			case speed
			case deg
		}
	}

	struct ForeSys: Decodable{
		var pod: String?

		private enum CodingKeys: String, CodingKey {
			case pod
		}
	}
}
