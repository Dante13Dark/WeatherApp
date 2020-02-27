//
//  InteractorOutput.swift
//  WeatherApp
//
//  Created by Yaroslav Tutushkin on 27/02/2020.
//

/// Протокол обработчика данных приходящих от интерактора 
protocol InteractorOutput: AnyObject {
	/// Получена информация о текущей погоде.
	func received(currentWeather: CurrentWeather)

	/// Получена ошибка.
	func received(error: RequestServiceError)
}
