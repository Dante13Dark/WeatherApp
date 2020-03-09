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
		output.requestInfo()
	}
}

// MARK: - StartPresenterInput
extension StartPresenter: StartPresenterInput {
	func present(model: PresentationModel<Model>) {
		switch model {
		case let .loader(loaderIsHidden: value):
			view?.set(loaderIsHidden: value)
		case .responseModel(let model):
			switch model {
			case let .currentWeather(currentWeather):
				let model = WeatherViewModel(currentWeather: currentWeather).items
				view?.set(model: model)
				view?.set(city: currentWeather.name)
			case let .weatherForecast(weatherForecast):
				let model = WeatherViewModel(weatherForecast: weatherForecast).items
				view?.set(model: model)
			}
			view?.set(loaderIsHidden: true)
		}
	}
}
