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

// MARK: - LocationServiceOutput
extension Interactor: LocationServiceOutput {
	func didUpdate(coord: Coord) {
		requestInfo(coord: coord)
	}
}

// MARK: - InteractorInput
extension Interactor: InteractorInput {

	func requestInfo() {
		locationService.getCoord()
	}

	func requestInfo(coord: Coord) {
		getWeather(coord: coord, type: RequestType<CurrentWeather>())
		getWeather(coord: coord, type: RequestType<WeatherForecast>())
	}

	private enum RequestType<T> {
		case current
		case forecast
		case unknown

		init() {
			switch T.self {
			case is CurrentWeather.Type:
				self = .current
			case is WeatherForecast.Type:
				self = .forecast
			default:
				self = .unknown
			}
		}
	}

	private func getWeather<T: Decodable>(coord: Coord, type: RequestType<T>) {
		let url = makeUrl(coord: coord, type: type)

		requestService.run(url: url) { [weak self] (response: Result<T,RequestServiceError>) in
			guard let self = self else { return }
			switch response {
			case let .success(result):
				print("MODEL: \(result)")
				self.output?.received(model: result)
			case let .failure(error):
				self.output?.received(error: error)
			}
		}
	}

	private enum APIConstants: String {
		case apiKey = "&appid=cfeae8c84fe84eba49d6279199a24b24"
		case url = "https://api.openweathermap.org/data/2.5/"
	}

	private func makeUrl<T: Decodable>(coord: Coord, type: RequestType<T>) -> String {
		switch (type) {
		case .current:
			return "\(APIConstants.url.rawValue)weather?lat=\(String(coord.lat))&lon=\(String(coord.lon))&units=metric\(APIConstants.apiKey.rawValue)&lang=ru"
		case .forecast:
			return "\(APIConstants.url.rawValue)forecast?lat=\(String(coord.lat))&lon=\(String(coord.lon))&units=metric\(APIConstants.apiKey.rawValue)&lang=ru"
		case .unknown:
			return ""
		}
	}
}
