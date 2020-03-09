//
//  StartPresenterInput.swift
//  WeatherApp
//
//  Created by Yaroslav Tutushkin on 27/02/2020.
//

/// Протокол управления презентером стартового экрана.
protocol StartPresenterInput: AnyObject {
	// Установить модель
	func present(currentWeather: CurrentWeather)
	// Установить модель
	func present(weatherForecast: WeatherForecast)
}
