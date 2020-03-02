//
//  StartViewOutput.swift
//  WeatherApp
//
//  Created by Yaroslav Tutushkin on 27/02/2020.
//

/// Исходящий протокол view экрана.
protocol StartViewOutput: AnyObject {

	// Вью загружена
	func didLoad()
}
