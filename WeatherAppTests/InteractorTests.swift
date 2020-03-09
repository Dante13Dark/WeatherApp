//
//  InteractorTests.swift
//  WeatherAppTests
//
//  Created by Yaroslav Tutushkin on 10.03.2020.
//

@testable import WeatherApp
import XCTest

class InteractorTests: XCTestCase {

	var requestServiceProtocolSpy: RequestServiceProtocolSpy<WeatherForecast>!
	var locationServiceInputSpy: LocationServiceInputSpy!
	var interactor: Interactor!

	override func setUp() {
		super.setUp()
		requestServiceProtocolSpy = RequestServiceProtocolSpy()
		locationServiceInputSpy = LocationServiceInputSpy()
		interactor = Interactor(requestService: requestServiceProtocolSpy,
								locationService: locationServiceInputSpy)

	}

	override func tearDown() {
		interactor = nil
		requestServiceProtocolSpy = nil
		locationServiceInputSpy = nil
		
		super.tearDown()
	}

	// MARK: - InteractorInput

	func testRequestInfo() {
		// arrange

		// act
		interactor.requestInfo()

		// assert
		XCTAssertEqual(locationServiceInputSpy.latestCall, LocationServiceInputSpy.Call.getCoord)
	}

	func testRequestInfoWithCoord() {
		// arrange
		let coord = Coord(lat: 0, lon: 0)

		// act
		interactor.requestInfo(coord: coord)

		// assert
		XCTAssertNotNil(requestServiceProtocolSpy.responseHandler)
	}

	
}
