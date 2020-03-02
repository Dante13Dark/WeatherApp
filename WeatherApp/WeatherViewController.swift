//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Yaroslav Tutushkin on 27/02/2020.
//

import UIKit

class WeatherViewController: UIViewController {

	var id: Int?

	var currentWeather = CurrentWeatherView()

	var output: WeatherViewOutput
	
	init(output: WeatherViewOutput) {
		self.output = output
		super.init(nibName: nil, bundle: nil)
	}

	// Заглушка для обязательного инициализатора без реализации.
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .green
		view.addSubview(currentWeather)
		setupLayout()
	}

	override func viewWillAppear(_ animated: Bool) {
//		output.currentVC(viewController: self)
//		output.didLoad(id: id)
	}

	// MARK: - Private

	private func setupLayout() {
		currentWeather.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			currentWeather.topAnchor.constraint(equalTo: view.topAnchor),
			currentWeather.leftAnchor.constraint(equalTo: view.leftAnchor),
			currentWeather.rightAnchor.constraint(equalTo: view.rightAnchor),
			currentWeather.bottomAnchor.constraint(equalTo: view.bottomAnchor)
			])
	}
}

extension WeatherViewController: WeatherViewInput {
	func set(city: String, temp: String, icon: String) {
		DispatchQueue.main.async {
			super.navigationItem.title = city
			self.currentWeather.temperature.text = temp
			self.currentWeather.icon.image = UIImage(named: icon)
		}
	}
}

extension WeatherViewController: WeatherPresenterOutput {}
