//
//  FlowCoordinatorTests.swift
//  WeatherAppTests
//
//  Created by Yaroslav Tutushkin on 09.03.2020.
//

@testable import WeatherApp
import XCTest

class FlowCoordinatorTests: XCTestCase {

	enum TestError: Error {
		case some
	}

	var startPresenterInputSpy: StartPresenterInputSpy!
	var interactorInputSpy: InteractorInputSpy!
	var routerInputSpy: RouterInputSpy!
	var coordinator: FlowCoordinator!

	override func setUp() {
		super.setUp()

		startPresenterInputSpy = StartPresenterInputSpy()
		interactorInputSpy = InteractorInputSpy()
		routerInputSpy = RouterInputSpy()
		coordinator = FlowCoordinator(interactor: interactorInputSpy, router: routerInputSpy)
		coordinator.startPresenter = startPresenterInputSpy
	}

	override func tearDown() {
		coordinator = nil
		startPresenterInputSpy = nil
		interactorInputSpy = nil
		routerInputSpy = nil

		super.tearDown()
	}

	// MARK: - FlowCoordinatorProtocol

	func testStart() {
		// arrange

		// act
		coordinator.start()

		// assert
		XCTAssertEqual(routerInputSpy.latestCall, RouterInputSpy.Call.showStartScreen)
	}

	// MARK: - StartPresenterOutput

	func testRequestInfo() {
		// arrange

		// act
		coordinator.requestInfo()
		
		// assert
		XCTAssertEqual(startPresenterInputSpy.presentedModel, PresentationModel.loader(loaderIsHidden: false))
		XCTAssertEqual(interactorInputSpy.latestCall, InteractorInputSpy.Call.requestInfo)
	}

	// MARK: - InteractorOutput

	func testReceivedCurrentWeather() {
		// arrange
		guard let currentWeather = try? CurrentWeather(fileName: "1-currentWeather") else {
			XCTFail("Can't mock CurrentWeather")
			return
		}
		// act
		coordinator.received(currentWeather: currentWeather)

		// assert
		XCTAssertEqual(startPresenterInputSpy.presentedModel, PresentationModel.responseModel(.currentWeather(currentWeather)))
	}

	func testReceivedWeatherForecast() {
		// arrange
		guard let weatherForecast = try? WeatherForecast(fileName: "2-weatherForecast") else {
			XCTFail("Can't mock CurrentWeather")
			return
		}
		// act
		coordinator.received(weatherForecast: weatherForecast)

		// assert
		XCTAssertEqual(startPresenterInputSpy.presentedModel, PresentationModel.responseModel(.weatherForecast(weatherForecast)))
	}

	func testReceivedError() {
		// arrange
		let error = RequestServiceError.serverError(.init(message: "ALOHA"))

		// act
		coordinator.received(error: error)

		// assert
		XCTAssertEqual(startPresenterInputSpy.presentedModel, PresentationModel.loader(loaderIsHidden: true))
		XCTAssertEqual(routerInputSpy.latestCall, RouterInputSpy.Call.showErrorResponse(error))

	}
}
