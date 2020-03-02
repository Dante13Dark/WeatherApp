//
//  Assembly.swift
//  WeatherApp
//
//  Created by Yaroslav Tutushkin on 27/02/2020.
//

import UIKit
import Foundation
import CoreLocation

final class Assembly: NSObject {

	let loader = Loader()

	var window: UIWindow?

	var flowCoordinator: FlowCoordinatorProtocol {
		return coordinator
	}

	let locationService = LocationService()

	// Объект координатора.
	private var coordinator: FlowCoordinator {
		if let coordinator = coordinatorReference { return coordinator }
		let router = Router(assembly: self)

		let requestService = RequestService()
		let dataService = DataService()
		
		let interactor = Interactor(requestService: requestService,
									dataService: dataService)
		locationService.output = interactor
		let flowCoordinator = FlowCoordinator(interactor: interactor, router: router)
		interactor.output = flowCoordinator

		coordinatorReference = flowCoordinator

		return flowCoordinator
	}

	// Ссылка на координатор процесса.
	private weak var coordinatorReference: FlowCoordinator?

	init(window: UIWindow?) {
		self.window = window
		super.init()
	}

	func makeStartScreen() -> UIViewController {
		let presenter = StartPresenter(output: coordinator)
		coordinator.startPresenter = presenter

		let viewController = StartViewController(output: presenter)
		presenter.view = viewController

		return viewController
	}

	func makeWeatherScreen() -> UIViewController {
		let presenter = WeatherPresenter(output: coordinator)
		coordinator.weatherPresenter = presenter

		let viewController = WeatherViewController(output: presenter)
		presenter.view = viewController

		return viewController
	}

	func set(loaderIsHidden: Bool) {
		loader.set(loaderIsHidden: loaderIsHidden)
	}
}

enum Model {
	case location(Coord)
	case city(City)
}

