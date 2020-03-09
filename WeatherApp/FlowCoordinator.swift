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
	func showLoader() {
		router.set(loaderIsHidden: false)
	}
}


// MARK: - InteractorOutput
extension FlowCoordinator: InteractorOutput {

	func received(model: Model) {
		interactor.requestInfo(model: model)
	}
	
	func received(currentWeather: CurrentWeather) {
		startPresenter?.present(currentWeather: currentWeather)
		router.set(loaderIsHidden: true)
	}

	func received(weatherForecast: WeatherForecast) {
		startPresenter?.present(weatherForecast: weatherForecast)
		router.set(loaderIsHidden: true)
	}

	func received(error: RequestServiceError) {
		self.router.set(loaderIsHidden: true)
		self.router.showErrorResponse(error)
	}
}
