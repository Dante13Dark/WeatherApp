//
//  StartPresenter.swift
//  WeatherApp
//
//  Created by Yaroslav Tutushkin on 27/02/2020.
//

import Foundation

final class StartPresenter {
	// MARK: - Properties

	/// View экрана
	weak var view: StartViewInput?

	// Обработчик событий и запросов презентера стартового.
	private var output: StartPresenterOutput

	init(output: StartPresenterOutput) {
		self.output = output
	}
}

// MARK: - StartViewOutput
extension StartPresenter: StartViewOutput {
	func didLoad() {
		output.showLoader()
	}
}

// MARK: - StartPresenterInput
extension StartPresenter: StartPresenterInput {
	func set(currentWeather: CurrentWeather) {
		let model = WeatherViewModel(currentWeather: currentWeather).items
		view?.set(city: currentWeather.name)
		view?.set(model: model)
	}
}
