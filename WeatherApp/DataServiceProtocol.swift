//
//  DataServiceProtocol.swift
//  WeatherApp
//
//  Created by Yaroslav Tutushkin on 02.03.2020.
//

import Foundation

protocol DataServiceProtocol {
	/// Получить данные
	func load() -> [City]

	/// Сохранить данные
	func save(data: [City])
}
