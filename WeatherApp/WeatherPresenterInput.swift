//
//  WeatherPresenterInput.swift
//  WeatherApp
//
//  Created by Yaroslav Tutushkin on 03.03.2020.
//

protocol WeatherPresenterInput: AnyObject {
	// Установить модель для VC
	func set(model: CurrentWeather)
}
