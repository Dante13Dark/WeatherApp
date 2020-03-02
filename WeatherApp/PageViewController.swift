//
//  PageViewController.swift
//  WeatherApp
//
//  Created by Yaroslav Tutushkin on 29.02.2020.
//

import UIKit
import CoreLocation

class PageViewController: UIPageViewController
{
	// MARK: Location
	let locationManager = CLLocationManager()

	private func setupLocation() {
		locationManager.delegate = self

		locationManager.requestWhenInUseAuthorization()

		if (CLLocationManager.authorizationStatus() == .authorizedWhenInUse || CLLocationManager.authorizationStatus() == .authorizedAlways) {
			locationManager.requestLocation()
		}
	}

	// Properties

	var coord = Coord(lat: 55.751244, lon: 37.618423)

	let savedArray: [City] = {
		if let decoded  = UserDefaults.standard.object(forKey: "SavedCities") as? Data {
			if let savedData = try? PropertyListDecoder().decode(Array<City>.self, from: decoded) {
				print(savedData)
				return savedData
			}
		}
		return []
	}()

	fileprivate lazy var pages: [UIViewController] = {
		var array: [UIViewController] = []
		array.append(WeatherViewController(output: self))
		savedArray.forEach({ city in
			array.append(addVC(with: city.id))
		})

		return array
	}()

	private func addVC(with id: Int) -> WeatherViewController {
		let vc = WeatherViewController(output: self)
		vc.id = id
		return vc
	}
	var currentIndex: Int = 0

	// презентер экрана
	var output: ViewOutput

	init(output: ViewOutput) {
		self.output = output
		super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
	}

	// Заглушка для обязательного инициализатора без реализации.
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}


	override func viewDidLoad()
	{
		super.viewDidLoad()
		self.dataSource = self
		self.delegate = self
		view.backgroundColor = .cyan
		setupButton()
		setupLocation()

		if let firstVC = pages.first
		{
			setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
		}
	}

	func setupButton() {
		let button = UIBarButtonItem(image: UIImage(named: "10d"), style: .plain,
									 target: self, action: #selector(action))
		navigationItem.rightBarButtonItem  = button
	}

	@objc func action() {
		let vc = ListOfCitiesViewController(nibName: nil, bundle: nil)
		vc.savedCities = savedArray
		navigationController?.pushViewController(vc, animated: true)
	}
}

extension PageViewController: UIPageViewControllerDelegate {}


extension PageViewController: PageDelegate {
	func didLoad(id: Int?) {
		if let id = id {
			output.didLoad(id: id)
		} else {
			output.didLoad(coord: coord)
		}
	}

	func currentVC(viewController: WeatherViewController) {
		guard let viewControllerIndex = pages.firstIndex(of: viewController) else { return }
		currentIndex = viewControllerIndex
		print("CURRENT INDEX = \(currentIndex)")
	}
}

extension PageViewController: UIPageViewControllerDataSource
{
	func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {

		guard let viewControllerIndex = pages.firstIndex(of: viewController) else { return nil }

		let previousIndex = viewControllerIndex - 1

		guard previousIndex >= 0 else {
			return pages.last
		}

		guard pages.count > previousIndex else { return nil }

		return pages[previousIndex]
	}

	func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController?
	{
		guard let viewControllerIndex = pages.firstIndex(of: viewController) else { return nil }

		let nextIndex = viewControllerIndex + 1

		guard nextIndex < pages.count else {

			return pages.first
		}

		guard pages.count > nextIndex else { return nil }

		return pages[nextIndex]
	}
}

extension PageViewController: ViewInput {
	func set(title: String) {
		DispatchQueue.main.async {
			self.navigationItem.title = title
		}
	}

	func set(model: CurrentWeather) {
		if let currentVC = pages[currentIndex] as? WeatherViewController {
			currentVC.set(model: model)
		}
	}

	func set(loaderIsHidden: Bool) {
		Indicator.sharedInstance.set(loaderIsHidden: loaderIsHidden)
	}
}


extension PageViewController: CLLocationManagerDelegate {
	func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
		print("location manager authorization status changed")
	}

	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		if let location = locations.first {
			coord = Coord(lat: location.coordinate.latitude, lon: location.coordinate.longitude)
			print("ЛОКАЦИЯ БЫЛА ОБНОВЛЕНА НА \(coord.lat) \(coord.lon)")
		}
	}

	func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
		print(error.localizedDescription)
	}
}
