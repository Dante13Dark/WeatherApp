//
//  RequestServiceProtocolSpy.swift
//  WeatherAppTests
//
//  Created by Yaroslav Tutushkin on 10.03.2020.
//

@testable import WeatherApp

final class RequestServiceProtocolSpy<ResultModelType: Decodable> {
	private(set) var responseHandler: ((Result<ResultModelType, RequestServiceError>) -> Void)?
}

extension RequestServiceProtocolSpy: RequestServiceProtocol {
	func run<ResultType>(url: String, responseHandler: @escaping (Result<ResultType, RequestServiceError>) -> Void) where ResultType : Decodable {
		self.responseHandler = responseHandler as? ((Result<ResultModelType, RequestServiceError>) -> Void)
	}
}
