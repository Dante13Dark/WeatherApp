//
//  WeatherForecastTests.swift
//  WeatherAppTests
//
//  Created by Yaroslav Tutushkin on 09.03.2020.
//

@testable import WeatherApp
import XCTest

class WeatherForecastTests: XCTestCase {

	func testDecodeWeatherForecast() {
		// arrange
		let fileName = "2-weatherForecast"
		guard let fileData = readFile(fileName) else {
			XCTFail("Can't read file \(fileName).")
			return
		}

		// act & assert
		XCTAssertNoThrow(try JSONDecoder().decode(WeatherForecast.self, from: fileData),
						 "Failed for \"\(fileName).json\"")
	}

	func testDecodeError() {
		// arrange
		let fileName = "3-error"
		guard let fileData = readFile(fileName) else {
			XCTFail("Can't read file \(fileName).")
			return
		}

		// arrange & act
		XCTAssertThrowsError(try JSONDecoder().decode(WeatherForecast.self, from: fileData)) { error in
			// assert
			guard error is ServerError else {
				return XCTFail()
			}
		}
	}

	// MARK: - Helpers

	private func readFile(_ fileName: String) -> Data? {
		guard let path = Bundle(for: WeatherForecastTests.self).path(forResource: fileName, ofType: ".json")
			else { return nil }
		return try? Data(contentsOf: URL(fileURLWithPath: path))
	}
}
