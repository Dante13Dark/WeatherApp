//
//  ViewOutput.swift
//  WeatherApp
//
//  Created by Yaroslav Tutushkin on 27/02/2020.
//

/// Исходящий протокол view экрана.
protocol ViewOutput: AnyObject {

	// Вью загружена
	func didLoad(id: Int)

	func didLoad(coord: Coord)
}
