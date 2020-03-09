//
//  LocationServiceInputSpy.swift
//  WeatherAppTests
//
//  Created by Yaroslav Tutushkin on 10.03.2020.
//

@testable import WeatherApp

final class LocationServiceInputSpy {

	enum Call: Equatable {
		case none
		case getCoord
	}

	private(set) var latestCall: Call = .none
}


extension LocationServiceInputSpy: LocationServiceInput {
	func getCoord() {
		latestCall = .getCoord
	}
}
