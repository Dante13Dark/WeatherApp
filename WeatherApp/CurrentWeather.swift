//
//  CurrentWeather.swift
//  Weather
//
//  Created by Yaroslav Tutushkin on 25.02.2020.
//  Copyright © 2020 Yaroslav Tutushkin. All rights reserved.
//
enum Model: Equatable {
	case currentWeather(CurrentWeather)
	case weatherForecast(WeatherForecast)
}

struct CurrentWeather: Decodable, Equatable {

	var coord: Coord
	var weather: [Weather]
	var base: String?
	var main: Main
	var visibility: Int
	var wind: Wind
	var clouds: Clouds
	var dt: Int
	var sys: Sys
	var timezone: Int
	var id: Int
	var name: String
	var cod: Int
	var message: String = ""

	private enum CodingKeys: String, CodingKey {
		case coord
		case weather
		case base
		case main
		case visibility
		case wind
		case clouds
		case dt = "dt"
		case sys = "sys"
		case timezone = "timezone"
		case id
		case name
		case cod
		case message
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		cod = try container.decode(Int.self, forKey: .cod)

		if container.contains(.message) {
			message = try container.decode(String.self, forKey: .message)
			throw ServerError(message: message)
		} else {
			coord = try container.decode(Coord.self, forKey: .coord)
			weather = try container.decode([Weather].self, forKey: .weather)
			base = try? container.decode(String.self, forKey: .base)
			main = try container.decode(Main.self, forKey: .main)
			visibility = try container.decode(Int.self, forKey: .visibility)
			wind = try container.decode(Wind.self, forKey: .wind)
			clouds = try container.decode(Clouds.self, forKey: .clouds)
			dt = try container.decode(Int.self, forKey: .dt)
			sys = try container.decode(Sys.self, forKey: .sys)
			timezone = try container.decode(Int.self, forKey: .timezone)
			id = try container.decode(Int.self, forKey: .id)
			name = try container.decode(String.self, forKey: .name)
		}
	}
}


// MARK: - Clouds
struct Clouds: Decodable, Equatable {
	var all: Int
	private enum CodingKeys: String, CodingKey {
		case all
	}
}

// MARK: - Coord
struct Coord: Codable, Equatable {
	var lat: Double
	var lon: Double

	private enum CodingKeys: String, CodingKey {
		case lat
		case lon
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(lat, forKey: .lat)
		try container.encode(lon, forKey: .lon)
	}
}

// MARK: - Main
struct Main: Decodable, Equatable {
	var temp: Double
	var feelsLike: Double
	var pressure: Int
	var humidity: Int
	var tempMin: Double
	var tempMax: Double

	private enum CodingKeys: String, CodingKey {
		case temp
		case feelsLike = "feels_like"
		case pressure
		case humidity
		case tempMin = "temp_min"
		case tempMax = "temp_max"
	}
}

// MARK: - Sys
struct Sys: Decodable, Equatable {
	var type: Int?
	var id: Int?
	var message: Double?
	var country: String
	var sunrise: Int
	var sunset: Int

	private enum CodingKeys: String, CodingKey {
		case type
		case id
		case message
		case country
		case sunrise
		case sunset
	}
}

// MARK: - Weather
struct Weather: Decodable, Equatable {
	var id: Int
	var main: String
	var weatherDescription: String
	var icon: String

	private enum CodingKeys: String, CodingKey {
		case id
		case main
		case weatherDescription = "description"
		case icon
	}
}

// MARK: - Wind
struct Wind: Decodable, Equatable {
	var speed: Double
	var deg: Int?

	private enum CodingKeys: String, CodingKey {
		case speed
		case deg
	}
}
