//
//  DataService.swift
//  WeatherApp
//
//  Created by Yaroslav Tutushkin on 02.03.2020.
//

import Foundation

final class DataService: DataServiceProtocol {
	func load() -> [City] {
		if let decoded  = UserDefaults.standard.object(forKey: "SavedData") as? Data {
			if let savedData = try? PropertyListDecoder().decode(Array<City>.self, from: decoded) {
				print(savedData)
				return savedData
			}
		} else {
			print("NOT DECODE")
		}
		return []
	}

	func save(data: [City]) {
		if let encoded = try? PropertyListEncoder().encode(data) {
			UserDefaults.standard.set(encoded, forKey:"SavedData")
		} else {
			print("NOT ENCODE")
		}
	}


}
