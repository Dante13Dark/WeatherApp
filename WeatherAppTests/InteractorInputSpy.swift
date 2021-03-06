//
//  InteractorInputSpy.swift
//  WeatherAppTests
//
//  Created by Yaroslav Tutushkin on 09.03.2020.
//

@testable import WeatherApp

final class InteractorInputSpy {

	enum Call: Equatable {
		case none
		case requestInfo
	}

	private(set) var latestCall: Call = .none
}


extension InteractorInputSpy: InteractorInput {

	func requestInfo() {
		latestCall = .requestInfo
	}
}
