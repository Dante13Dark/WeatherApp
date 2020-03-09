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
			icon.image = UIImage(named: item.iconName)
		}
	}

	lazy var icon: UIImageView = {
		let icon = UIImageView()
		NSLayoutConstraint.activate([
			icon.widthAnchor.constraint(equalToConstant: 100),
			icon.heightAnchor.constraint(equalToConstant: 100)
			])
		return icon
	}()

	lazy var temp: UILabel = {
		let label = UILabel()
		label.font = label.font.withSize(100)
		label.textColor = .black
		return label
	}()

	lazy var desc: UILabel = {
		let desc = UILabel()
		desc.numberOfLines = 0
		desc.font = desc.font.withSize(20)
		desc.textColor = .black
		return desc
	}()

	lazy var feelsLike: UILabel = {
		let feelsLike = UILabel()
		feelsLike.numberOfLines = 0
		feelsLike.font = desc.font.withSize(20)
		feelsLike.textColor = .black
		return feelsLike
	}()

	lazy var horizontalStack: UIStackView = {
		let stackView = UIStackView(arrangedSubviews: [temp, icon])
		stackView.axis = .horizontal
		stackView.spacing = 10
		stackView.alignment = .center
		stackView.distribution = .equalSpacing
		return stackView
	}()

	lazy var stackView: UIStackView = {
		let stackView = UIStackView(arrangedSubviews: [desc, horizontalStack, feelsLike])
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
