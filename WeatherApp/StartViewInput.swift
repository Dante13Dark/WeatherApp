//
//  StartViewInput.swift
//  WeatherApp
//
//  Created by Yaroslav Tutushkin on 27/02/2020.
//

/// Управляющий протокол view стартового экрана.
protocol StartViewInput: AnyObject {
	/// Установить заголовок
	func set(city: String)
	/// Установить модель
	func set(model: [WeatherViewModelItem])
	/// Установить видимость лоадера
	/// - Parameter loaderIsHidden: Состояние лоадера: если true, то скрыт.
	func set(loaderIsHidden: Bool)
}

