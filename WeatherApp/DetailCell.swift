//
//  DetailCell.swift
//  WeatherApp
//
//  Created by Yaroslav Tutushkin on 08.03.2020.
//

import UIKit

/// Ячейка дополнительной информации о погоде
final class DetailCell: UITableViewCell {

	var item: WeatherViewModelItem? {
		didSet {
			guard let item = item as? DetailsViewModelItem else {
				return
			}

			textLabel?.text = item.title
			detailTextLabel?.text = item.detail
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
