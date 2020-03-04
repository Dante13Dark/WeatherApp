//
//  CitiesViewController.swift
//  WeatherApp
//
//  Created by Yaroslav Tutushkin on 01.03.2020.
//

import UIKit
import CoreData

final class CitiesViewController: UIViewController {

	// MARK: - Search
	var cities: [City] = []

	var filteredCities: [City] = []

	var isSearchBarEmpty: Bool {
		return searchController.searchBar.text?.isEmpty ?? true
	}

	private var searchController: UISearchController = {
		let searchController = UISearchController(searchResultsController: nil)
		searchController.obscuresBackgroundDuringPresentation = false
		searchController.definesPresentationContext = true
		searchController.searchBar.placeholder = "Введите имя города"
		return searchController
	}()

	func filterContentForSearchText(_ searchText: String) {
		filteredCities = cities.filter { (city: City) -> Bool in
			return city.name.lowercased().contains(searchText.lowercased())
		}
		savedCities = filteredCities

		tableView.reloadData()
	}

	//

	var savedCities:[City] = []

	let tableView: UITableView = {
		let tv = UITableView()
		tv.backgroundColor = UIColor.white
		tv.separatorColor = UIColor.white
		tv.translatesAutoresizingMaskIntoConstraints = false
		return tv
	}()

	override func viewDidLoad() {
		super.viewDidLoad()
		cities = RequestService().getCities()

		navigationItem.title = "Список городов"

		navigationItem.searchController = searchController
		searchController.searchResultsUpdater = self

		setupTableView()
		setupLayout()

		updateTableContent()
	}

	func updateTableContent() {
	}

	func setupTableView() {
		tableView.register(CityCell.self, forCellReuseIdentifier: "City")
		tableView.delegate = self
		tableView.dataSource = self

		view.addSubview(tableView)
	}

	func setupLayout() {

		NSLayoutConstraint.activate([
			tableView.topAnchor.constraint(equalTo: view.topAnchor),
			tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
			tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
			tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
			])
	}
}

extension CitiesViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 100
	}

	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
			self.savedCities.remove(at: indexPath.row)
			tableView.deleteRows(at: [indexPath], with: .fade)
		}
	}
}

extension CitiesViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

		return savedCities.count
	}

	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "City", for: indexPath) as? CityCell else { return UITableViewCell() }

		cell.backgroundColor = UIColor.white
		cell.set(city: savedCities[indexPath.row])
		return cell
	}
}

extension CitiesViewController: UISearchResultsUpdating {
	func updateSearchResults(for searchController: UISearchController) {
		if isSearchBarEmpty { return }
		NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(reload), object: nil)
		self.perform(#selector(reload), with: nil, afterDelay: 3)
	}

	@objc func reload() {
		let searchBar = searchController.searchBar
		filterContentForSearchText(searchBar.text!)
	}
}
