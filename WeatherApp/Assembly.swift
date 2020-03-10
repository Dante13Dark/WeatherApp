//
//  Assembly.swift
//  WeatherApp
//
//  Created by Yaroslav Tutushkin on 27/02/2020.
//

import UIKit
import Foundation
import CoreLocation

/// Сборщик процесса.
/// Используется для запуска процесса. Конструирует и агрегирует объекты необходимые для процесса.
final class Assembly: NSObject {

	var window: UIWindow?

	var flowCoordinator: FlowCoordinatorProtocol {
		return coordinator
	}

	/// Сервис локации
	let locationService = LocationService()

	// Объект координатора.
	private var coordinator: FlowCoordinator {
		if let coordinator = coordinatorReference { return coordinator }
		let router = Router(assembly: self)

		let requestService = RequestService()

		let interactor = Interactor(requestService: requestService,
									locationService: locationService)
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


	/// Создать стартовый экран
	///
	/// - Returns: Стартовый View Controller
	func makeStartScreen() -> UIViewController {
		let presenter = StartPresenter(output: coordinator)
		coordinator.startPresenter = presenter

		let viewController = StartViewController(output: presenter)
		presenter.view = viewController

		return viewController
	}
}

