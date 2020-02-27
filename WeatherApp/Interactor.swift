//
//  Interactor.swift
//  WeatherApp
//
//  Created by Yaroslav Tutushkin on 27/02/2020.
//

import Foundation

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

	func requestInfo() {
		let url = "https://api.openweathermap.org/data/2.5/weather?lat=55.751244&lon=37.618423&units=metric&appid=cfeae8c84fe84eba49d6279199a24b24&lang=ru"
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

