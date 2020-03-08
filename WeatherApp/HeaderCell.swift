//
//  HeaderCell.swift
//  WeatherApp
//
//  Created by Yaroslav Tutushkin on 05.03.2020.
//

import UIKit

final class HeaderCell: UITableViewCell {

	var item: WeatherViewModelItem? {
		didSet {
			guard let item = item as? HeaderViewModelItem else {
				return
			}

			temp.text = item.temp
			desc.text = item.desc
			feelsLike.text = item.feelsLike
		}
	}

	lazy var temp: UILabel = {
		let label = UILabel()
		label.font = label.font.withSize(120)
		label.textColor = .black
		return label
	}()

	lazy var desc: UILabel = {
		let desc = UILabel()
		desc.numberOfLines = 0
		desc.font = desc.font.withSize(40)
		desc.textColor = .black
		return desc
	}()

	lazy var feelsLike: UILabel = {
		let feelsLike = UILabel()
		feelsLike.numberOfLines = 0
		feelsLike.font = desc.font.withSize(40)
		feelsLike.textColor = .black
		return feelsLike
	}()

	lazy var stackView: UIStackView = {
		let stackView = UIStackView(arrangedSubviews: [desc, temp, feelsLike])
		stackView.axis = .vertical
		stackView.spacing = 10
		stackView.alignment = .center
		return stackView
	}()

	// MARK: - Initializer

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		selectionStyle = .none
		backgroundColor = .clear
		setupLayout()
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func setupLayout() {
		stackView.translatesAutoresizingMaskIntoConstraints = false
		contentView.addSubview(stackView)

		NSLayoutConstraint.activate([
			stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
			stackView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
			stackView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
			stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
			])
	}
}
