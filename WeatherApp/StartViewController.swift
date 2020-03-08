//
//  StartViewController.swift
//  WeatherApp
//
//  Created by Yaroslav Tutushkin on 27/02/2020.
//

import UIKit

class StartViewController: UIViewController {

	lazy var tableView = TableView(frame: .zero, style: .grouped)

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
		[tableView].forEach {
			view.addSubview($0)
			$0.translatesAutoresizingMaskIntoConstraints = false
		}
		NSLayoutConstraint.activate([
			tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
			tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
			tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
			])
	}
}

extension StartViewController: StartViewInput {
	func set(city: String, temp: String, desc: String) {
		DispatchQueue.main.async {
			self.navigationItem.title = city
			self.tableView.set(temp: temp, desc: desc)
//			self.currentWeather.temperature.text = temp
//			self.currentWeather.icon.image = UIImage(named: icon)
		}
	}
}
