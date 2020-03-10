//
//  TableView.swift
//  WeatherApp
//
//  Created by Yaroslav Tutushkin on 09.03.2020.
//

import UIKit

/// Таблица с информацией о погоде
final class TableView: UITableView {

	var model: [WeatherViewModelItem]? {
		didSet {
			guard let items = model else {
				return
			}
			if (items.filter { $0 is ScrollViewModelItem }.count) != 0,
				self.items.count > 1 {
				self.items.insert(contentsOf: items, at: 2)
			} else {
				self.items = items
			}
			DispatchQueue.main.async {
				self.reloadData()
			}
		}
	}

	private var items: [WeatherViewModelItem] = []

	override init(frame: CGRect, style: UITableView.Style) {
		super.init(frame: frame, style: style)
		dataSource = self
		delegate = self
		separatorStyle = .none
		backgroundColor = .clear
		estimatedRowHeight = 100
		register(HeaderCell.self, forCellReuseIdentifier: String(describing: HeaderCell.self))
		register(TodayCell.self, forCellReuseIdentifier: String(describing: TodayCell.self))
		register(DetailCell.self, forCellReuseIdentifier: String(describing: DetailCell.self))
		register(ScrollCell.self, forCellReuseIdentifier: String(describing: ScrollCell.self))
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}


	// MARK: - UITableView

extension TableView: UITableViewDelegate {
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return UITableView.automaticDimension
	}
}

extension TableView: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return items.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let item = items[indexPath.row]
		switch item.type {
		case .header:
			if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HeaderCell.self), for: indexPath) as? HeaderCell {
				cell.item = item
				return cell
			}
		case .today:
			if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TodayCell.self), for: indexPath) as? TodayCell {
				cell.item = item
				return cell
			}
		case .detail:
			if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DetailCell.self), for: indexPath) as? DetailCell {
				cell.item = item
				return cell
			}
		case .forecast:
			if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ScrollCell.self), for: indexPath) as? ScrollCell {
				cell.item = item
				return cell
			}
		}
		return UITableViewCell()
	}
}
