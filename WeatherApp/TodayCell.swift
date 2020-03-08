//
//  TodayCell.swift
//  WeatherApp
//
//  Created by Yaroslav Tutushkin on 08.03.2020.
//

import UIKit

final class TodayCell: UITableViewCell {

	var item: WeatherViewModelItem? {
		didSet {
			guard let item = item as? TodayViewModelItem else {
				return
			}

			date.text = item.date
			tempMax.text = item.tempMax
			tempMin.text = item.tempMin
			iconView.image = UIImage(named: item.iconName)
			weekDay.text = "Сегодня"
		}
	}

	lazy var date: UILabel = {
		let date = UILabel()
		date.textColor = .black
		return date
	}()

	lazy var weekDay: UILabel = {
		let weekDay = UILabel()
		weekDay.textColor = .red
		return weekDay
	}()

	lazy var verticalStack: UIStackView = {
		let stack = UIStackView(arrangedSubviews: [date, weekDay])
		stack.axis = .vertical
		stack.spacing = 5
		return stack
	}()

	lazy var tempMin: UILabel = {
		let tempMin = UILabel()
		tempMin.textColor = .black
		return tempMin
	}()

	lazy var tempMax: UILabel = {
		let tempMax = UILabel()
		tempMax.textColor = .black
		return tempMax
	}()

	lazy var iconView: UIImageView = {
		let icon = UIImageView()
		icon.contentMode = .scaleAspectFit
		return icon
	}()

	lazy var horizontalStack: UIStackView = {
		let stackView = UIStackView(arrangedSubviews: [iconView, tempMax, tempMin])
		stackView.axis = .horizontal
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
		[verticalStack, horizontalStack].forEach {
			$0.translatesAutoresizingMaskIntoConstraints = false
			contentView.addSubview($0)
		}

		NSLayoutConstraint.activate([
			verticalStack.topAnchor.constraint(equalTo: contentView.topAnchor),
			verticalStack.leftAnchor.constraint(equalTo: contentView.leftAnchor),
			verticalStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
			horizontalStack.topAnchor.constraint(equalTo: contentView.topAnchor),
			horizontalStack.leftAnchor.constraint(equalTo: verticalStack.rightAnchor),
			horizontalStack.rightAnchor.constraint(equalTo: contentView.rightAnchor),
			horizontalStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
			])
	}
}
