//
//  WeatherPresenter.swift
//  WeatherApp
//
//  Created by Yaroslav Tutushkin on 03.03.2020.
//

import Foundation

final class WeatherPresenter {
	// MARK: Properties

	/// View экрана
	weak var view: WeatherViewInput?

	// Обработчик событий и запросов презентера стартового.
	private var output: WeatherPresenterOutput

	init(output: WeatherPresenterOutput) {
		self.output = output
	}
}

extension WeatherPresenter: WeatherPresenterInput {

	func set(model: CurrentWeather) {
		makeItem(model: model)
	}

	private func makeItem(model: CurrentWeather) {
		if let city = model.name,
			let icon = model.weather?.first?.icon,
			let temp = model.main?.temp {

			view?.set(city: city, temp: String(temp.rounded(.up)) + "°C", icon: icon)
		}
	}
}

extension WeatherPresenter: WeatherViewOutput {}
