//
//  StartViewInput.swift
//  WeatherApp
//
//  Created by Yaroslav Tutushkin on 27/02/2020.
//

/// Управляющий протокол view стартового экрана.
protocol StartViewInput: AnyObject {
	/// Установить модель
	func set(city: String, temp: String, icon: String)
}

