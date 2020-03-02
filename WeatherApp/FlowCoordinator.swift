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
	// Презентер экрана погоды
	weak var weatherPresenter: WeatherPresenterInput?
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


// MARK: - WeatherPresenterOutput
extension FlowCoordinator: WeatherPresenterOutput { }


// MARK: - InteractorOutput
extension FlowCoordinator: InteractorOutput {

	func received(model: Model) {
		router.addWeatherScreen()
		interactor.requestInfo(model: model)
	}
	
	func received(currentWeather: CurrentWeather) {
		weatherPresenter?.set(model: currentWeather)
		router.set(loaderIsHidden: true)
	}

	func received(error: RequestServiceError) {
		print(error)
//		DispatchQueue.main.async {
//			Indicator.sharedInstance.set(loaderIsHidden: true)
//			self.router.showErrorResponse(error)
//		}
	}

	// ресивд запрашивает у ассембли 
}
