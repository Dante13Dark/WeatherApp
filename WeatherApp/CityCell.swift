//
//  CityCell.swift
//  WeatherApp
//
//  Created by Yaroslav Tutushkin on 01.03.2020.
//

import UIKit

final class CityCell: UITableViewCell {

	let cellView: UIView = {
		let view = UIView()
		view.backgroundColor = UIColor.red
		view.layer.cornerRadius = 10
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()

	let dayLabel: UILabel = {
		let label = UILabel()
		label.text = "Day 1"
		label.textColor = UIColor.white
		label.font = UIFont.boldSystemFont(ofSize: 16)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)

		addSubview(cellView)
		cellView.addSubview(dayLabel)
		selectionStyle = .none

		setupLayout()
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func setupLayout() {

		NSLayoutConstraint.activate([
			cellView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
			cellView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
			cellView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
			cellView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
			dayLabel.heightAnchor.constraint(equalToConstant: 200),
			dayLabel.widthAnchor.constraint(equalToConstant: 200),
			dayLabel.centerYAnchor.constraint(equalTo: cellView.centerYAnchor),
			dayLabel.leftAnchor.constraint(equalTo: cellView.leftAnchor, constant: 20)
			])

	}

	func set(city: City) {
		DispatchQueue.main.async {
			self.dayLabel.text = city.name
		}
	}
}
