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
				 (.showErrorResponse,.showErrorResponse),
				 (.show,.show):
				return true
			default:
				return false
			}
		}

		case none
		case showStartScreen
		case showErrorResponse(RequestServiceError)
		case show(loaderIsHidden: Bool)
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

	func show(loaderIsHidden: Bool) {
		latestCall = .show(loaderIsHidden: loaderIsHidden)
	}
}
