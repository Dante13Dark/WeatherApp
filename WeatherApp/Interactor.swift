//
//  Interactor.swift
//  WeatherApp
//
//  Created by Yaroslav Tutushkin on 27/02/2020.
//

import Foundation
import CoreData

/// Интерактор
final class Interactor {

	weak var output: InteractorOutput?

	private let requestService: RequestServiceProtocol

	private let dataService: DataServiceProtocol

	init(requestService: RequestServiceProtocol,
		 dataService: DataServiceProtocol) {
		self.requestService = requestService
		self.dataService = dataService
	}
}


// MARK: - InteractorInput
extension Interactor: InteractorInput {
	func requestInfo(model: Model) {
		switch model {
		case .city(let city):
			let id = Int(city.id)
			let url = "https://api.openweathermap.org/data/2.5/weather?id=\(id)&units=metric&appid=cfeae8c84fe84eba49d6279199a24b24&lang=ru"
			run(url: url)
		case .location(let coord):
			let url = "https://api.openweathermap.org/data/2.5/weather?lat=\(String(coord.lat))&lon=\(String(coord.lon))&units=metric&appid=cfeae8c84fe84eba49d6279199a24b24&lang=ru"
			run(url: url)
		}
	}

	private func run(url: String) {
		requestService.run(url: url) { [weak self] (response: Result<CurrentWeather, RequestServiceError>) in
			guard let self = self else { return }
			switch response {
			case let .success(result):
				self.output?.received(currentWeather: result)
			case let .failure(error):
				self.output?.received(error: error)
			}
		}
	}
}

extension Interactor: LocationServiceProtocol {
	// локация и потом дергает дата сорс
	func didUpdate(coord: Coord) {
		output?.received(model: Model.location(coord))
		dataService.load().forEach { city in
			output?.received(model: Model.city(city))
		}
	}
}
