//
//  InteractorInput.swift
//  WeatherApp
//
//  Created by Yaroslav Tutushkin on 27/02/2020.
//

/// Протокол для управления событиями
protocol InteractorInput {
	/// Запросить информацию о погоде для текущего экрана
	func requestInfo()
}
