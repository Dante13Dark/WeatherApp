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

	private let locationService: LocationServiceInput

	init(requestService: RequestServiceProtocol,
		 dataService: DataServiceProtocol,
		 locationService: LocationServiceInput) {
		self.requestService = requestService
		self.dataService = dataService
		self.locationService = locationService
	}
}


// MARK: - InteractorInput
extension Interactor: InteractorInput {

	func requestInfo(index: Int) {
		locationService.getCoord()
	}

	func requestInfo(model: Model) {
		getCurrentWeather(url: makeUrl(model: model, type: .weather))
		getWeatherForecast(url: makeUrl(model: model, type: .forecast))
	}

	enum APIConstants: String {
		case apiKey = "&appid=cfeae8c84fe84eba49d6279199a24b24"
		case url = "https://api.openweathermap.org/data/2.5/"
	}

	enum RequestType: String {
		case weather = "weather?"
		case forecast = "forecast?"
	}

	private func makeUrl(model: Model, type: RequestType) -> String {
		switch (model, type) {
		case (let .location(coord), .weather):
			return "\(APIConstants.url.rawValue)\(RequestType.weather.rawValue)lat=\(String(coord.lat))&lon=\(String(coord.lon))&units=metric\(APIConstants.apiKey.rawValue)&lang=ru"
		case (let .location(coord), .forecast):
			return "\(APIConstants.url.rawValue)\(RequestType.forecast.rawValue)lat=\(String(coord.lat))&lon=\(String(coord.lon))&units=metric\(APIConstants.apiKey.rawValue)&lang=ru"
		case (let .city(city), .weather):
			let id = Int(city.id)
			return "\(APIConstants.url.rawValue)\(RequestType.weather.rawValue)id=\(id)&units=metric\(APIConstants.apiKey.rawValue)&lang=ru"
		case (let .city(city), .forecast):
			let id = Int(city.id)
			return "\(APIConstants.url)\(RequestType.forecast)id=\(id)&units=metric\(APIConstants.apiKey)&lang=ru"
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
		output?.received(model: Model.location(coord))
	}
}
