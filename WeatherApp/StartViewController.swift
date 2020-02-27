//
//  StartViewController.swift
//  WeatherApp
//
//  Created by Yaroslav Tutushkin on 27/02/2020.
//

import UIKit

class StartViewController: UIViewController {

	// Внутренние константы для ячейки.
	private enum Constants {
		// Отступы контента от границ ячейки.
		static let contentInset: CGFloat = 16
		// Отступ между элементами внутри ячейки.
		static let internalSpacing: CGFloat = 8
	}

	lazy var temperature: UILabel = {
		return theLabel(title: "", fontSize: 120, fontColor: .black)
	}()

	lazy var icon: UIImageView = {
		let icon = UIImageView()
		icon.translatesAutoresizingMaskIntoConstraints = false
		return icon
	}()

	// презентер экрана
	var output: ViewOutput

	init(output: ViewOutput) {
		self.output = output
		super.init(nibName: nil, bundle: nil)
	}

	// Заглушка для обязательного инициализатора без реализации.
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .red
		view.addSubview(temperature)
		view.addSubview(icon)
		setupLayout()
		output.didLoad()
	}

	// MARK: - Private

	private func setupLayout() {
		NSLayoutConstraint.activate([
			temperature.topAnchor.constraint(equalTo: view.topAnchor, constant:200),
			temperature.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			temperature.heightAnchor.constraint(equalToConstant: 100),
			icon.topAnchor.constraint(equalTo: temperature.bottomAnchor, constant: Constants.contentInset),
			icon.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			icon.heightAnchor.constraint(equalToConstant: 100),
			icon.widthAnchor.constraint(equalToConstant: 100)
			])
	}
	// удалить
	private func theLabel(title: String, fontSize: CGFloat, fontColor: UIColor) -> UILabel {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = label.font.withSize(fontSize)
		label.textColor = fontColor
		label.text = title

		return label
	}
}

extension StartViewController: ViewInput {
	func set(title: String) {
		DispatchQueue.main.async {
			self.navigationItem.title = title
		}
	}

	func set(loaderIsHidden: Bool) {
		Indicator.sharedInstance.set(loaderIsHidden: loaderIsHidden)
	}

	func set(model: CurrentWeather) {
		print("Model = \(model)")
		// просто посмотреть
		DispatchQueue.main.async {
			if let temp = model.main?.temp {
				self.temperature.text = String(Int(temp)) + "°C"
			}

			if let icon = model.weather?.first?.icon {
				self.icon.image = UIImage.init(named: icon)
			}
		}
	}
}
