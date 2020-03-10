//
//  InteractorOutput.swift
//  WeatherApp
//
//  Created by Yaroslav Tutushkin on 27/02/2020.
//

/// Протокол обработчика данных приходящих от интерактора 
protocol InteractorOutput: AnyObject {
	/// Получена модель данных о погоде
	func received<T: Decodable>(model: T)
	/// Получена ошибка.
	func received(error: RequestServiceError)
}
