//
//  StartPresenterInput.swift
//  WeatherApp
//
//  Created by Yaroslav Tutushkin on 27/02/2020.
//

/// Протокол управления презентером стартового экрана.
protocol StartPresenterInput: AnyObject {
//	// Презентовать модель текущей погоды
//	func present(currentWeather: PresentationModel<CurrentWeather>)
//	// Презентовать модель сводки о погоде
//	func present(weatherForecast: PresentationModel<WeatherForecast>)
	// Презентовать модель сводки о погоде
	func present(model: PresentationModel<Model>)
}
