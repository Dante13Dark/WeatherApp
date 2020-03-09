//
//  Router.swift
//  WeatherApp
//
//  Created by Yaroslav Tutushkin on 27/02/2020.
//

import UIKit

final class Router {

	let loader: LoaderProtocol = Loader()

	var assembly: Assembly

	init(assembly: Assembly) {
		self.assembly = assembly
	}
}


// MARK: - RouterInput
extension Router: RouterInput {
	func show(loaderIsHidden: Bool) {
		loader.set(loaderIsHidden: loaderIsHidden)
	}

	func showStartScreen() {
		let viewController = assembly.makeStartScreen()
		let navigationController = UINavigationController(rootViewController: viewController)
		navigationController.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
		navigationController.navigationBar.shadowImage = UIImage()
		navigationController.navigationBar.isTranslucent = true
		navigationController.view.backgroundColor = UIColor.clear
		navigationController.navigationBar.prefersLargeTitles = true
		assembly.window?.rootViewController = navigationController
		assembly.window?.makeKeyAndVisible()
	}

	func showErrorResponse(_ error: RequestServiceError) {
		DispatchQueue.main.async {
			let alert = UIAlertController(title: "Ошибка!",
										  message: error.localizedDescription,
										  preferredStyle: .alert)
			let cancel = UIAlertAction(title: "Ок",
									   style: .cancel)
			alert.addAction(cancel)
			self.assembly.window?.rootViewController?.present(alert, animated: true)
		}
	}
}
