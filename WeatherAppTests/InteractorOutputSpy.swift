//
//  InteractorOutputSpy.swift
//  WeatherAppTests
//
//  Created by Yaroslav Tutushkin on 09.03.2020.
//

@testable import WeatherApp

final class InteractorOutputSpy<T: Decodable> {
	enum Call: Equatable {
		case none
		case error
		case model
	}

	private(set) var latestCall: Call = .none
}

extension InteractorOutputSpy: InteractorOutput {
	func received<T>(model: T) where T : Decodable {
		latestCall = .model
	}

	func received(error: RequestServiceError) {
		latestCall = .error
	}
}
