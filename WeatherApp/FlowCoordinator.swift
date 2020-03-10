//
//  FlowCoordinator.swift
//  WeatherApp
//
//  Created by Yaroslav Tutushkin on 27/02/2020.
//

import Foundation

final class FlowCoordinator {
	// Презентер стартового экрана
	weak var startPresenter: StartPresenterInput?
	// Интерактор процесса.
	private var interactor: InteractorInput
	// Роутер процесса.
	private var router: RouterInput

	init(interactor: InteractorInput, router: RouterInput) {
		self.interactor = interactor
		self.router = router
	}
}

extension FlowCoordinator: FlowCoordinatorProtocol {
	func start() {
		router.showStartScreen()
	}
}


// MARK: - StartPresenterOutput
extension FlowCoordinator: StartPresenterOutput {
	func requestInfo() {
		startPresenter?.present(model: .loader(loaderIsHidden: false))
		interactor.requestInfo()
	}
}


// MARK: - InteractorOutput
extension FlowCoordinator: InteractorOutput {
	func received<T>(model: T) where T : Decodable {
		if let model = model as? CurrentWeather {
			startPresenter?.present(model: .responseModel(.currentWeather(model)))
		} else if let model = model as? WeatherForecast {
			startPresenter?.present(model: .responseModel(.weatherForecast(model)))
		}
	}

	
	func received(currentWeather: CurrentWeather) {
		startPresenter?.present(model: .responseModel(.currentWeather(currentWeather)))
	}

	func received(weatherForecast: WeatherForecast) {
		startPresenter?.present(model: .responseModel(.weatherForecast(weatherForecast)))
	}

	func received(error: RequestServiceError) {
		startPresenter?.present(model: .loader(loaderIsHidden: true))
		router.showErrorResponse(error)
	}
}
