//
//  InteractorInput.swift
//  WeatherApp
//
//  Created by Yaroslav Tutushkin on 27/02/2020.
//

/// Протокол для управления событиями
protocol InteractorInput {
	// Запросить информацию о погоде по id города
	func requestInfo(id: Int)
	// Запросить информацию о погоде по текущей геопозицие
	func requestInfo(coord: Coord)
}
