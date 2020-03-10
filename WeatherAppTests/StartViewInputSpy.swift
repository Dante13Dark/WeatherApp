//
//  StartViewInputSpy.swift
//  WeatherAppTests
//
//  Created by Yaroslav Tutushkin on 10.03.2020.
//

@testable import WeatherApp

final class StartViewInputSpy {
	private(set) var loaderIsHidden: Bool?
	private(set) var city: String?
	private(set) var model: [WeatherViewModelItem]?
}

extension StartViewInputSpy: StartViewInput {
	func set(city: String) {
		self.city = city
	}

	func set(model: [WeatherViewModelItem]) {
		self.model = model
	}

	func set(loaderIsHidden: Bool) {
		self.loaderIsHidden = loaderIsHidden
	}
}
