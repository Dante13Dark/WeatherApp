//
//  StartPresenterInputSpy.swift
//  WeatherAppTests
//
//  Created by Yaroslav Tutushkin on 09.03.2020.
//

@testable import WeatherApp

final class StartPresenterInputSpy {
	private(set) var presentedCurrentWeather: PresentationModel<CurrentWeather>?
	private(set) var presentedWeatherForecast: PresentationModel<WeatherForecast>?
}

extension StartPresenterInputSpy: StartPresenterInput {
	func present(currentWeather: CurrentWeather) {
		presentedCurrentWeather = currentWeather
	}

	func present(weatherForecast: WeatherForecast) {
		presentedWeatherForecast = weatherForecast
	}
}
