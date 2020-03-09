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

			textLabel?.text = item.date
			detailTextLabel?.text = "Макс. \(item.tempMax)" + "/" + "Мин. \(item.tempMin)"
			imageView?.image = UIImage(named: item.iconName)
		}
	}

	// MARK: - Initializer

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: .value1, reuseIdentifier: reuseIdentifier)
		selectionStyle = .none
		backgroundColor = .clear
		detailTextLabel?.textColor = .black
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
