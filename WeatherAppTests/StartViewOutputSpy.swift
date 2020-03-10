//
//  StartViewOutputSpy.swift
//  WeatherAppTests
//
//  Created by Yaroslav Tutushkin on 10.03.2020.
//

@testable import WeatherApp

final class StartViewOutputSpy {
	enum Call: Equatable {
		case none
		case didLoad
	}

	private(set) var latestCall: Call = .none
}

extension StartViewOutputSpy: StartViewOutput {
	func didLoad() {
		latestCall = .didLoad
	}
}
