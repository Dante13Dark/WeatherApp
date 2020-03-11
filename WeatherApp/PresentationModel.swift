//
//  PresentationModel.swift
//  WeatherApp
//
//  Created by Yaroslav Tutushkin on 27/02/2020.
//

/// Общая модель презентеров.
enum PresentationModel<ResponseModelType: Equatable>: Equatable {
	/// Началась загрузка
	case loader(loaderIsHidden: Bool)
	/// Получили данные
	case responseModel(ResponseModelType)
}

/// Модель данных погоды
enum Model: Equatable {
	case currentWeather(CurrentWeather)
	case weatherForecast(WeatherForecast)
}
