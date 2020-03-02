//
//  Assembly.swift
//  WeatherApp
//
//  Created by Yaroslav Tutushkin on 27/02/2020.
//

import UIKit
import Foundation

final class Assembly: NSObject {

	var window: UIWindow?

	var flowCoordinator: FlowCoordinatorProtocol {
		return coordinator
	}

	// Объект координатора.
	private var coordinator: FlowCoordinator {
		if let coordinator = coordinatorReference { return coordinator }
		let requestService = RequestService()
		let router = Router(assembly: self)
		let interactor = Interactor(requestService: requestService)
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

		let viewController = PageViewController(output: presenter)
		presenter.view = viewController

		return viewController
	}
}
