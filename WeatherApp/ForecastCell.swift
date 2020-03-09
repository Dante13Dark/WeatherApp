//
//  ForecastCell.swift
//  WeatherApp
//
//  Created by Yaroslav Tutushkin on 08.03.2020.
//

import UIKit

final class ForecastCell: UICollectionViewCell {

	var item: ForecastViewModelItem? {
		didSet {
			guard item != nil else {
				return
			}
			time.text = item?.time
			temp.text = item?.temp
			icon.image = UIImage(named: item?.icon ?? "")
		}
	}

	lazy var icon: UIImageView = {
		let icon = UIImageView()
		icon.contentMode = .scaleAspectFit
		return icon
	}()

	lazy var temp: UILabel = {
		let label = UILabel()
		label.textColor = .black
		return label
	}()

	lazy var time: UILabel = {
		let desc = UILabel()
		desc.textColor = .black
		return desc
	}()

	lazy var stack: UIStackView = {
		let stack = UIStackView(arrangedSubviews: [time, icon, temp])
		stack.axis = .vertical
		stack.alignment = .center
		stack.spacing = 5.0
		return stack
	}()

	override init(frame: CGRect) {
		super.init(frame: frame)
		backgroundColor = .clear
		setupLayout()
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private func setupLayout() {
		stack.translatesAutoresizingMaskIntoConstraints = false
		contentView.addSubview(stack)

		NSLayoutConstraint.activate([
			stack.topAnchor.constraint(equalTo: contentView.topAnchor),
			stack.leftAnchor.constraint(equalTo: contentView.leftAnchor),
			stack.rightAnchor.constraint(equalTo: contentView.rightAnchor),
			stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
		])
	}
}
