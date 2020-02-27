//
//  StartPresenterOutput.swift
//  WeatherApp
//
//  Created by Yaroslav Tutushkin on 27/02/2020.
//

/// Протокол обработки событий и запросов презентера стартового экрана.
protocol StartPresenterOutput {
	/// Запрашивается информация для стартового экрана.
	func requestDataForStartScreen()

	/// Показать экран деталей по доверенному лицу.
//	func showDetails(trusteeData: AccountSharingResponse.Screen.TrusteeData)
}
