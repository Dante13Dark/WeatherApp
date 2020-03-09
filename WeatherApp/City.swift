//
//  City.swift
//  WeatherApp
//
//  Created by Yaroslav Tutushkin on 01.03.2020.
//

import Foundation

struct City: Codable, Equatable {

	var id: Int
	var name: String
	var country: String
	var coord: Coord
	var timezone: Int?
	var sunrise: Int?
	var sunset: Int?

	private enum CodingKeys: String, CodingKey {
		case coord
		case id
		case name
		case country
		case timezone
		case sunrise
		case sunset
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		coord = try container.decode(Coord.self, forKey: .coord)
		country = try container.decode(String.self, forKey: .country)
		id = try container.decode(Int.self, forKey: .id)
		name = try container.decode(String.self, forKey: .name)
		timezone = try? container.decode(Int.self, forKey: .timezone)
		sunrise = try? container.decode(Int.self, forKey: .sunrise)
		sunset = try? container.decode(Int.self, forKey: .sunset)
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(name, forKey: .name)
		try container.encode(id, forKey: .id)
		try container.encode(country, forKey: .country)
		try container.encode(coord, forKey: .coord)
		try? container.encode(timezone, forKey: .timezone)
		try? container.encode(sunrise, forKey: .sunrise)
		try? container.encode(sunset, forKey: .sunset)
	}
}
