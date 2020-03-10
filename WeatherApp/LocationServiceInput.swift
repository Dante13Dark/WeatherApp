//
//  LocationServiceInput.swift
//  WeatherApp
//
//  Created by Yaroslav Tutushkin on 04.03.2020.
//

/// Протокол для управления событиями
protocol LocationServiceInput {
	/// Запросить текущую геопозицию
	func getCoord()
}
