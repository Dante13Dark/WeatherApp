//
//  StartPresenterInput.swift
//  WeatherApp
//
//  Created by Yaroslav Tutushkin on 27/02/2020.
//

/// Протокол управления презентером стартового экрана.
protocol StartPresenterInput: AnyObject {
	// Установить модель
	func set(currentWeather: CurrentWeather)
}
