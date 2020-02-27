//
//  ViewInput.swift
//  WeatherApp
//
//  Created by Yaroslav Tutushkin on 27/02/2020.
//

/// Управляющий протокол view экрана.
protocol ViewInput: AnyObject {
	/// Установить заголовок экрана
	///
	/// - Parameter title: заголовок
	func set(title: String)

	/// Установить модель данных для view
	///
	/// - Parameter model: модель данных для view
	func set(model: CurrentWeather)

	/// Установить видимость лоадера
	/// - Parameter loaderIsHidden: Состояние лоадера: если true, то скрыт.
	func set(loaderIsHidden: Bool)
}

