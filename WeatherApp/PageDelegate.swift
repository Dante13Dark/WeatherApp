//
//  PageDelegate.swift
//  WeatherApp
//
//  Created by Yaroslav Tutushkin on 01.03.2020.
//

protocol PageDelegate: AnyObject {
	// Возвращает текущий VC
	func currentVC(viewController: WeatherViewController)
	// Вью загружена с id
	func didLoad(id: Int?)
}
