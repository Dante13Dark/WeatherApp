//
//  CurrentWeatherView.swift
//  WeatherApp
//
//  Created by Yaroslav Tutushkin on 29.02.2020.
//

import UIKit

final class CurrentWeatherView: UIView {

	// MARK: - Properties

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


	// MARK: - Init

	override init(frame: CGRect) {
		super.init(frame: .zero)
		backgroundColor = .clear
		addSubview(temperature)
		addSubview(icon)

		setupLayout()
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}


	// MARK: - Private
	private func setupLayout() {
		NSLayoutConstraint.activate([
			temperature.topAnchor.constraint(equalTo: topAnchor, constant:200),
			temperature.centerXAnchor.constraint(equalTo: centerXAnchor),
			temperature.heightAnchor.constraint(equalToConstant: 100),
			icon.topAnchor.constraint(equalTo: temperature.bottomAnchor, constant: Constants.contentInset),
			icon.centerXAnchor.constraint(equalTo: centerXAnchor),
			icon.heightAnchor.constraint(equalToConstant: 100),
			icon.widthAnchor.constraint(equalToConstant: 100)
			])
	}

	private func theLabel(title: String, fontSize: CGFloat, fontColor: UIColor) -> UILabel {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = label.font.withSize(fontSize)
		label.textColor = fontColor
		label.text = title

		return label
	}
}

