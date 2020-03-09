//
//  StartPresenterOutput.swift
//  WeatherApp
//
//  Created by Yaroslav Tutushkin on 27/02/2020.
//

/// Протокол обработки событий и запросов презентера стартового экрана.
protocol StartPresenterOutput {
	/// Запросить информацию
	func requestInfo()
}
