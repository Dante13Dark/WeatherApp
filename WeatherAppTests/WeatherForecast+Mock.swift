//
//  WeatherForecast+Mock.swift
//  WeatherAppTests
//
//  Created by Yaroslav Tutushkin on 09.03.2020.
//

@testable import WeatherApp
import Foundation


extension WeatherForecast {
	/// Создаёт объект CurrentWeather по json-файлу включенному в тестовый бандл.
	init(fileName: String) throws {
		guard let path = Bundle(for: WeatherForecastTests.self).path(forResource: fileName, ofType: ".json"),
			let fileData = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
				fatalError("Can't read file \(fileName).")
		}
		self = try JSONDecoder().decode(WeatherForecast.self, from: fileData)
	}
}
