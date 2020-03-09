//
//  CurrentWeatherTests.swift
//  WeatherAppTests
//
//  Created by Yaroslav Tutushkin on 09.03.2020.
//

@testable import WeatherApp
import XCTest

class CurrentWeatherTests: XCTestCase {

	func testDecodeCurrentWeather() {
		// arrange
		let fileName = "1-currentWeather"
		guard let fileData = readFile(fileName) else {
			XCTFail("Can't read file \(fileName).")
			return
		}

		// act & assert
		XCTAssertNoThrow(try JSONDecoder().decode(CurrentWeather.self, from: fileData),
						 "Failed for \"\(fileName).json\"")
	}

	func testDecodeCurrentWeatherError() {
		// arrange
		let fileName = "3-error"
		guard let fileData = readFile(fileName) else {
			XCTFail("Can't read file \(fileName).")
			return
		}

		// arrange & act
		XCTAssertThrowsError(try JSONDecoder().decode(CurrentWeather.self, from: fileData)) { error in
			// assert
			guard error is ServerError else {
				return XCTFail()
			}
		}
	}

	// MARK: - Helpers

	private func readFile(_ fileName: String) -> Data? {
		guard let path = Bundle(for: CurrentWeatherTests.self).path(forResource: fileName, ofType: ".json")
			else { return nil }
		return try? Data(contentsOf: URL(fileURLWithPath: path))
	}
}
