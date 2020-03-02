//
//  StartPresenterOutput.swift
//  WeatherApp
//
//  Created by Yaroslav Tutushkin on 27/02/2020.
//

/// Протокол обработки событий и запросов презентера стартового экрана.
protocol StartPresenterOutput {
	/// Запрашивается информация для экрана по id города.
	func requestData(for id: Int)

	/// Запрашивается информация для экрана с геопозицией
	func requestDataForFirstScreen(coord: Coord)
}
