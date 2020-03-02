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

	private enum CodingKeys: String, CodingKey {
		case coord
		case id
		case name
		case country
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		coord = try container.decode(Coord.self, forKey: .coord)
		country = try container.decode(String.self, forKey: .country)
		id = try container.decode(Int.self, forKey: .id)
		name = try container.decode(String.self, forKey: .name)
	}
	
	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(name, forKey: .name)
		try container.encode(id, forKey: .id)
		try container.encode(country, forKey: .country)
		try container.encode(coord, forKey: .coord)
	}
}
