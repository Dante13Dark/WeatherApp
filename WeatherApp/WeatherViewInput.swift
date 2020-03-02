//
//  WeatherViewInput.swift
//  WeatherApp
//
//  Created by Yaroslav Tutushkin on 03.03.2020.
//

protocol WeatherViewInput: AnyObject {
	// Установить основные параметры на экран
	func set(city: String, temp: String, icon: String)
}
