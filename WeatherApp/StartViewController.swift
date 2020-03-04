//
//  StartViewController.swift
//  WeatherApp
//
//  Created by Yaroslav Tutushkin on 27/02/2020.
//

import UIKit

class StartViewController: UIViewController {

	var currentWeather = CurrentWeatherView()

	var output: StartViewOutput
	
	init(output: StartViewOutput) {
		self.output = output
		super.init(nibName: nil, bundle: nil)
	}

	// Заглушка для обязательного инициализатора без реализации.
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .cyan
		setupLayout()

		output.didLoad()
	}

	// MARK: - Private

	private func setupLayout() {
		[currentWeather].forEach {
			view.addSubview($0)
			$0.translatesAutoresizingMaskIntoConstraints = false
		}
		NSLayoutConstraint.activate([
			currentWeather.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			currentWeather.leftAnchor.constraint(equalTo: view.leftAnchor),
			currentWeather.rightAnchor.constraint(equalTo: view.rightAnchor),
			currentWeather.heightAnchor.constraint(equalToConstant: 200)
//			currentWeather.bottomAnchor.constraint(equalTo: view.bottomAnchor)
			])
	}
}

extension StartViewController: StartViewInput {
	func set(city: String, temp: String, icon: String) {
		DispatchQueue.main.async {
			self.navigationItem.title = city
			self.currentWeather.temperature.text = temp
			self.currentWeather.icon.image = UIImage(named: icon)
		}
	}
}
