//
//  FlowCoordinator.swift
//  WeatherApp
//
//  Created by Yaroslav Tutushkin on 27/02/2020.
//

import Foundation

final class FlowCoordinator {

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
	func requestDataForStartScreen() {
		startPresenter?.present(.loader)
		interactor.requestInfo()
	}
}

// MARK: - InteractorOutput
extension FlowCoordinator: InteractorOutput {
	func received(currentWeather: CurrentWeather) {
		startPresenter?.present(.responseModel(currentWeather))
	}

	func received(error: RequestServiceError) {
		print(error)
		router.showErrorResponse(error)
	}
}
