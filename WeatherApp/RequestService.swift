//
//  RequestService.swift
//  WeatherApp
//
//  Created by Yaroslav Tutushkin on 27/02/2020.
//

import Foundation

final class RequestService: RequestServiceProtocol {

	func run<ResultType: Decodable>(
		url: String,
		responseHandler: @escaping (Result<ResultType, RequestServiceError>) -> Void
		) {
		guard let url = URL(string: url) else {
			responseHandler(.failure(.unknown))
			return
		}
		print("URL: \(url)")

		URLSession.shared.dataTask(with: url){ (data, response, err) in

			guard let data = data else {
				return
			}
			do {
				print("JSON RESPONSE: \(String(data: data, encoding: .utf8)!)")
				let obj = try JSONDecoder().decode(ResultType.self, from: data)

				if let current = obj as? CurrentWeather,
					let cod = current.cod, let message = current.message {
					switch cod {
					case 401, 404, 429:
						responseHandler(.failure(.api(cod, message)))
					default:
						responseHandler(.success(obj))
					}
				}

				responseHandler(.success(obj))
			} catch {
				responseHandler(.failure(.converter(error)))
			}
			}.resume()
	}



//	func run<T: Decodable>(
//		url: String,
//		completion: @escaping (T, Error?) -> Void){
//
//		let url = URL(string: url)
//
//		print("URL: \(url!)")
//
//		URLSession.shared.dataTask(with: url!){(data,  response, err) in
//
//			guard let data = data else {return}
//			do {
//				print("JSON RESPONSE: \(String(data: data, encoding: .utf8)!)")
//				let obj = try JSONDecoder().decode(T.self, from: data)
//				completion(obj, err as Error?)
//
//			} catch let jsonErr {
//
//				print("Failed to decode json:", jsonErr)
//			}
//			}.resume()
//
//	}
}
