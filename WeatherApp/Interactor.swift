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

	private let locationService: LocationServiceInput

	init(requestService: RequestServiceProtocol,
		 locationService: LocationServiceInput) {
		self.requestService = requestService
		self.locationService = locationService
	}
}

// MARK: - InteractorInput
extension Interactor: InteractorInput {

	func requestInfo() {
		locationService.getCoord()
	}

	func requestInfo(coord: Coord) {
		getCurrentWeather(url: makeUrl(coord: coord, type: .weather))
		getWeatherForecast(url: makeUrl(coord: coord, type: .forecast))
	}

	private enum APIConstants: String {
		case apiKey = "&appid=cfeae8c84fe84eba49d6279199a24b24"
		case url = "https://api.openweathermap.org/data/2.5/"
	}

	private enum RequestType: String {
		case weather = "weather?"
		case forecast = "forecast?"
	}

	private func makeUrl(coord: Coord, type: RequestType) -> String {
		switch (type) {
		case .weather:
			return "\(APIConstants.url.rawValue)\(RequestType.weather.rawValue)lat=\(String(coord.lat))&lon=\(String(coord.lon))&units=metric\(APIConstants.apiKey.rawValue)&lang=ru"
		case .forecast:
			return "\(APIConstants.url.rawValue)\(RequestType.forecast.rawValue)lat=\(String(coord.lat))&lon=\(String(coord.lon))&units=metric\(APIConstants.apiKey.rawValue)&lang=ru"
		}
	}

	private func getCurrentWeather(url: String) {
		requestService.run(url: url) { [weak self] (response: Result<CurrentWeather, RequestServiceError>) in
			guard let self = self else { return }
			switch response {
			case let .success(result):
				print("MODEL: \(result)")
				self.output?.received(currentWeather: result)
			case let .failure(error):
				self.output?.received(error: error)
			}
		}
	}

	private func getWeatherForecast(url: String) {
		requestService.run(url: url) { [weak self] (response: Result<WeatherForecast, RequestServiceError>) in
			guard let self = self else { return }
			switch response {
			case let .success(result):
				print("MODEL: \(result)")
				self.output?.received(weatherForecast: result)
			case let .failure(error):
				self.output?.received(error: error)
			}
		}
	}
}

extension Interactor: LocationServiceOutput {
	func didUpdate(coord: Coord) {
		requestInfo(coord: coord)
	}
}
