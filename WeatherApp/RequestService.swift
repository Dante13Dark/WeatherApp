//
//  RequestService.swift
//  WeatherApp
//
//  Created by Yaroslav Tutushkin on 27/02/2020.
//

import Foundation

/// Сетевой сервис
final class RequestService: RequestServiceProtocol {

	func run<ResultType: Decodable>(
		url: String,
		responseHandler: @escaping (Result<ResultType, RequestServiceError>) -> Void
		) {
		guard let url = URL(string: url) else {
			responseHandler(.failure(.badURL))
			return
		}
		print("URL: \(url)")

		URLSession.shared.dataTask(with: url) { (data, response, err) in

			guard let data = data else {
				responseHandler(.failure(.noData))
				return
			}
			do {
				print("JSON RESPONSE: \(String(data: data, encoding: .utf8)!)")
				let obj = try JSONDecoder().decode(ResultType.self, from: data)
				responseHandler(.success(obj))
			} catch let error as ServerError {
				responseHandler(.failure(.serverError(error)))
			} catch {
				responseHandler(.failure(.converter(error)))
			}
			}.resume()
	}
}
