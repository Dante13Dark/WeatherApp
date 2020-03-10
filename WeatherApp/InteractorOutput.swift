//
//  InteractorOutput.swift
//  WeatherApp
//
//  Created by Yaroslav Tutushkin on 27/02/2020.
//

/// Протокол обработчика данных приходящих от интерактора 
protocol InteractorOutput: AnyObject {
	/// Получена модель данных о погоде
	///
	/// - Parameter model: Модель
	func received<T: Decodable>(model: T)
	/// Получена ошибка.
	///
	/// - Parameter error: Ошибка выполнения запроса
	func received(error: RequestServiceError)
}
