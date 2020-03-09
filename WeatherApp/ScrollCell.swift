//
//  ScrollCell.swift
//  WeatherApp
//
//  Created by Yaroslav Tutushkin on 08.03.2020.
//

import UIKit

final class ScrollCell: UITableViewCell {

	var item: WeatherViewModelItem? {
		didSet {
			guard let item = item as? ScrollViewModelItem else {
				return
			}
			items = item.items
			
			DispatchQueue.main.async {
				self.collectionView.reloadData()
			}
		}
	}

	var items: [ForecastViewModelItem] = []

	lazy var collectionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .horizontal
		layout.estimatedItemSize = CGSize(width: 1, height: 1)
		layout.itemSize = UICollectionViewFlowLayout.automaticSize
		let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
		let collection = UICollectionView(frame: frame, collectionViewLayout: layout)
		collection.backgroundColor = .clear
		collection.showsHorizontalScrollIndicator = true
		collection.showsVerticalScrollIndicator = false
		return collection
	}()

	// MARK: - Initializer

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		collectionView.dataSource = self
		collectionView.register(ForecastCell.self, forCellWithReuseIdentifier: String(describing: ForecastCell.self))
		selectionStyle = .none
		backgroundColor = .clear
		setupLayout()
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
		return collectionView.collectionViewLayout.collectionViewContentSize
	}

	func setupLayout() {
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		contentView.addSubview(collectionView)
		NSLayoutConstraint.activate([
			collectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
			collectionView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
			collectionView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
			collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
			])
	}
}

extension ScrollCell: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		let count = items.count
		return count
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ForecastCell.self), for: indexPath) as? ForecastCell {
			cell.item = items[indexPath.row]
			return cell
		}
		return UICollectionViewCell()
	}
}
