//
//  StartPresenterTests.swift
//  WeatherAppTests
//
//  Created by Yaroslav Tutushkin on 10.03.2020.
//

@testable import WeatherApp
import XCTest

class StartPresenterTests: XCTestCase {

	var presenter: StartPresenter!
	var outputSpy: StartPresenterOutputSpy!
	var viewSpy: StartViewInputSpy!

	override func setUp() {
		super.setUp()
		outputSpy = StartPresenterOutputSpy()
		presenter = StartPresenter(output: outputSpy)
		viewSpy = StartViewInputSpy()
		presenter.view = viewSpy
	}

	override func tearDown() {
		viewSpy = nil
		presenter = nil
		outputSpy = nil
		super.tearDown()
	}

	// MARK: - StartPresenterInput

	func testPresentLoader() {
		// Act
		presenter.present(model: .loader(loaderIsHidden: false))

		// Assert
		XCTAssertEqual(viewSpy.loaderIsHidden, false)
	}

	func testPresentCurrentWeatherModel() {
		// Arrange
		guard let currentWeather = try? CurrentWeather(fileName: "1-currentWeather") else {
			XCTFail("Can't mock CurrentWeather")
			return
		}
		let expectedCount = 9
		let expectedCity = "Купертино"
		// Act
		presenter.present(model: .responseModel(.currentWeather(currentWeather)))

		// Assert
		XCTAssertEqual(viewSpy.loaderIsHidden, true)
		guard let items = viewSpy.model else {
			XCTFail("Not found expected form items")
			return
		}
		XCTAssertEqual(items.count, expectedCount)
		if (items.count == expectedCount) {
			XCTAssertEqual(items[0].type, .header)
			XCTAssertEqual(items[1].type, .today)
			items.dropFirst(2).forEach { (item) in
				XCTAssertEqual(item.type, .detail)
			}
		}
		XCTAssertEqual(currentWeather.name, expectedCity)
	}

	func testPresentWeatherForecastModel() {
		// Arrange
		guard let weatherForecast = try? WeatherForecast(fileName: "2-weatherForecast") else {
			XCTFail("Can't mock Weather Forecast")
			return
		}
		let expectedCount = 40

		// Act
		presenter.present(model: .responseModel(.weatherForecast(weatherForecast)))

		// Assert
		XCTAssertEqual(viewSpy.loaderIsHidden, true)
		guard let items = viewSpy.model else {
			XCTFail("Not found expected items")
			return
		}
		XCTAssertEqual(items.count, 1)
		guard let scrollModel = items.first as? ScrollViewModelItem else {
			XCTFail("Not found expected item")
			return
		}
		XCTAssertEqual(scrollModel.items.count, expectedCount)
		if (items.count == expectedCount) {
			items.forEach { (item) in
				XCTAssertEqual(item.type, .forecast)
			}
		}
	}

	// MARK: - StartViewOutput

	func testDidLoad() {
		// Act
		presenter.didLoad()

		// Assert
		XCTAssertEqual(outputSpy.latestCall, StartPresenterOutputSpy.Call.requestInfo)
	}

}
