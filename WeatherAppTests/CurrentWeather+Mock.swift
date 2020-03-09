//
//  CurrentWeather+Mock.swift
//  WeatherAppTests
//
//  Created by Yaroslav Tutushkin on 09.03.2020.
//

@testable import WeatherApp
import Foundation


extension CurrentWeather {
	/// Создаёт объект CurrentWeather по json-файлу включенному в тестовый бандл.
	init(fileName: String) throws {
		guard let path = Bundle(for: CurrentWeatherTests.self).path(forResource: fileName, ofType: ".json"),
			let fileData = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
				fatalError("Can't read file \(fileName).")
		}
		self = try JSONDecoder().decode(CurrentWeather.self, from: fileData)
	}
}
