//
//  Router.swift
//  WeatherApp
//
//  Created by Yaroslav Tutushkin on 27/02/2020.
//

import UIKit

final class Router {

	var assembly: Assembly

	var startViewController: UIViewController?

	init(assembly: Assembly) {
		self.assembly = assembly
	}
}


// MARK: - RouterInput
extension Router: RouterInput {
	func set(loaderIsHidden: Bool) {
		assembly.set(loaderIsHidden: loaderIsHidden)
	}


	func addWeatherScreen() {
		guard let pageVC = startViewController as? UIPageViewController else { return }
		var array:[UIViewController] = pageVC.viewControllers ?? []
			array.append(assembly.makeWeatherScreen())
		DispatchQueue.main.async {
			pageVC.setViewControllers(array, direction: .forward, animated: true, completion: nil)
		}
	}


	func showStartScreen() {
		let viewController = assembly.makeStartScreen()
		self.startViewController = viewController
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
		let alert = UIAlertController(title: "Ошибка!",
									  message: error.errorDescription ?? error.localizedDescription,
									  preferredStyle: .alert)
		let cancel = UIAlertAction(title: "Ок",
								   style: .cancel)
		alert.addAction(cancel)
		assembly.window?.rootViewController?.present(alert, animated: true)
	}


}
