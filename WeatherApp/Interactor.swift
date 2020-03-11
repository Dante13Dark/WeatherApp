//
//  Interactor.swift
//  WeatherApp
//
//  Created by Yaroslav Tutushkin on 27/02/2020.
//

import Foundation
import CoreData

/// Интерактор процесса
final class Interactor {
	/// Обработчик данных от интерактора.
	weak var output: InteractorOutput?
	/// Сетевой сервис
	private let requestService: RequestServiceProtocol
	/// Сервис локации
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

	private func getWeather<T: Decodable>(coord: Coord, type: RequestType<T>) {
		let url = APIConstants.url(type: type.rawValue, coord: coord)

		requestService.run(url: url) { [weak self] (response: Result<T,RequestServiceError>) in
			guard let self = self else { return }
			switch response {
			case let .success(result):
				self.output?.received(model: result)
			case let .failure(error):
				self.output?.received(error: error)
			}
		}
	}

	private enum RequestType<T>: String {
		case weather
		case forecast
		case unknown

		init() {
			switch T.self {
			case is CurrentWeather.Type:
				self = .weather
			case is WeatherForecast.Type:
				self = .forecast
			default:
				self = .unknown
			}
		}
	}
}

private struct APIConstants {
	private static let apiKey = "&appid=cfeae8c84fe84eba49d6279199a24b24"
	private static let urlAddress = "https://api.openweathermap.org/data/2.5/"
	private static let additional = "&units=metric&lang=ru"
	private static func stringCoord(coord: Coord) -> String {
		return "?lat=\(String(coord.lat))&lon=\(String(coord.lon))"
	}
	static func url(type: String, coord: Coord) -> String {
		return """
		\(APIConstants.urlAddress)\(type)\(APIConstants.stringCoord(coord: coord))\
		\(APIConstants.apiKey)\(APIConstants.additional)
		"""
	}
}
