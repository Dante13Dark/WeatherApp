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

	init(requestService: RequestServiceProtocol) {
		self.requestService = requestService
	}
}


// MARK: - InteractorInput
extension Interactor: InteractorInput {
	func requestInfo(coord: Coord) {
		let url = "https://api.openweathermap.org/data/2.5/weather?lat=\(String(coord.lat))&lon=\(String(coord.lon))&units=metric&appid=cfeae8c84fe84eba49d6279199a24b24&lang=ru"
		run(url: url)
	}


	func requestInfo(id: Int) {
		let id = String(id)
		let url = "https://api.openweathermap.org/data/2.5/weather?id=\(id)&units=metric&appid=cfeae8c84fe84eba49d6279199a24b24&lang=ru"
		run(url: url)
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

