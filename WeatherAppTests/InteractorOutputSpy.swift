//
//  InteractorOutputSpy.swift
//  WeatherAppTests
//
//  Created by Yaroslav Tutushkin on 09.03.2020.
//

@testable import WeatherApp

final class InteractorOutputSpy {

	private(set) var error: RequestServiceError?
	private(set) var currentWeather: CurrentWeather?
	private(set) var weatherForecast: WeatherForecast?
}

extension InteractorOutputSpy: InteractorOutput {
	func received(currentWeather: CurrentWeather) {
		self.currentWeather = currentWeather
	}

	func received(weatherForecast: WeatherForecast) {
		self.weatherForecast = weatherForecast
	}

	func received(error: RequestServiceError) {
		self.error = error
	}
}
