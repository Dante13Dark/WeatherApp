//
//  RequestServiceProtocol.swift
//  WeatherApp
//
//  Created by Yaroslav Tutushkin on 27/02/2020.
//

/// Ошибки выполнения запроса
enum RequestServiceError: Error {
	/// Неверный формат url
	case badURL
	/// Ошибка получения данных
	case noData
	/// Ошибка декодирования данных.
	case converter(Error)
	/// Ощибка пришедшая с сервера
	case serverError(ServerError)

	var localizedDescription: String? {
		switch self {
		case .badURL: return "Неверный формат URL"
		case .noData: return "Ошибка получения данных"
		case let .converter(error): return error.localizedDescription
		case let .serverError(error): return error.message
		}
	}
}

/// Ошибка пришедшая с сервера
struct ServerError: Error {
	/// Сообщение ошибки
	var message: String
}


/// Протокол сервиса выполнения запроса
protocol RequestServiceProtocol {
	/// Запустить выполнение запроса по указанному адресу
	///
	/// - Parameters:
	///   - url: Адрес
	///   - responseHandler: Обработчик результата запроса
	func run<ResultType: Decodable>(url: String,
									responseHandler: @escaping (Result<ResultType, RequestServiceError>) -> Void)
}
