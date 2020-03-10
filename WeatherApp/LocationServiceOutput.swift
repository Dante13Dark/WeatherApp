//
//  LocationServiceOutput.swift
//  WeatherApp
//
//  Created by Yaroslav Tutushkin on 02.03.2020.
//


/// Протокол обработчика данных приходящих из локационного сервиса
protocol LocationServiceOutput: AnyObject {
	/// Получить координаты
	///
	/// - Parameter coord: Координаты
	func didUpdate(coord: Coord)
}
