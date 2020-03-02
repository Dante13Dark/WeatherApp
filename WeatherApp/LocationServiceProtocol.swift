//
//  LocationServiceProtocol.swift
//  WeatherApp
//
//  Created by Yaroslav Tutushkin on 02.03.2020.
//

protocol LocationServiceProtocol: AnyObject {
	/// Получить координаты
	func didUpdate(coord: Coord)
}
