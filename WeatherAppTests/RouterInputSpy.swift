//
//  RouterInputSpy.swift
//  WeatherAppTests
//
//  Created by Yaroslav Tutushkin on 09.03.2020.
//

@testable import WeatherApp

final class RouterInputSpy {
	
	enum Call: Equatable {
		static func == (lhs: RouterInputSpy.Call, rhs: RouterInputSpy.Call) -> Bool {
			switch (lhs, rhs) {
			case (.showStartScreen, .showStartScreen),
				 (.showErrorResponse,.showErrorResponse):
				return true
			default:
				return false
			}
		}

		case none
		case showStartScreen
		case showErrorResponse(RequestServiceError)
	}

	private(set) var latestCall: Call = .none

}

extension RouterInputSpy: RouterInput {
	func showStartScreen() {
		latestCall = .showStartScreen
	}

	func showErrorResponse(_ error: RequestServiceError) {
		latestCall = .showErrorResponse(error)
	}
}
