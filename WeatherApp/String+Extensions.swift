//
//  String+Extensions.swift
//  WeatherApp
//
//  Created by Yaroslav Tutushkin on 10.03.2020.
//

extension String {
	func capitalizingFirstLetter() -> String {
		return prefix(1).capitalized + dropFirst()
	}

	mutating func capitalizeFirstLetter() {
		self = self.capitalizingFirstLetter()
	}
}
