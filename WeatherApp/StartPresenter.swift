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
	weak var view: ViewInput?

	// Обработчик событий и запросов презентера стартового.
	private var output: StartPresenterOutput

	init(output: StartPresenterOutput) {
		self.output = output
	}
}

// MARK: - StartPresenterInput
extension StartPresenter: StartPresenterInput {
	func present(_ model:PresentationModel<CurrentWeather>) {
		switch model {
		case .loader:
			print("Loader")
			view?.set(loaderIsHidden: false)
		case .responseModel(let model):
			print("model = \(model)")
			view?.set(loaderIsHidden: true)
			set(model: model)
		}
	}

	// здесь фабрику данные распарсить
	private func set(model: CurrentWeather) {
		if let title = model.name {
			view?.set(title: title)
			view?.set(model: model)
		}
	}
}

extension StartPresenter: ViewOutput {
	func didLoad(coord: Coord) {
		output.requestDataForFirstScreen(coord: coord)
	}

	func didLoad(id: Int) {
		output.requestData(for: id)
	}
}
