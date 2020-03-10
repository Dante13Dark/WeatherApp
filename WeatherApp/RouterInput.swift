//
//  RouterInput.swift
//  WeatherApp
//
//  Created by Yaroslav Tutushkin on 27/02/2020.
//

/// Протокол роутера
protocol RouterInput {
	/// Показать стартовый экран.
	func showStartScreen()

	/// Показать сообщение об ошибке пришедшее с сервера.
	///
	/// - Parameter error: Ошибка выполнения запроса
	func showErrorResponse(_ error: RequestServiceError)
}
