//
//  RequestServiceProtocol.swift
//  WeatherApp
//
//  Created by Yaroslav Tutushkin on 27/02/2020.
//

/// Ошибки выполнения запроса
enum RequestServiceError: Error {
	/// Неизвестная ошибка выполенния запроса.
	case unknown
	/// Ошибка конвертации данных.
	case converter(Error)
	/// Ошибка пришедшая с сервера
	case api(Int, String)

	var errorDescription: String? {
		switch self {
		case .unknown: return nil
		case let .converter(error): return error.localizedDescription
		case let .api(_, message): return message
		}
	}
}

protocol RequestServiceProtocol {
	func run<ResultType: Decodable>(url: String,
									responseHandler: @escaping (Result<ResultType, RequestServiceError>) -> Void)
}
