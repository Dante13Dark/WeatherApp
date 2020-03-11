//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Yaroslav Tutushkin on 08.03.2020.
//

import UIKit

/// Типы элементов модели погоды
///
/// - header: Заголовок погоды
/// - detail: Детали погоды
/// - today: Погода сегодня
/// - forecast: Сводка погоды
enum WeatherViewModelItemType {
	case header
	case detail
	case today
	case forecast
}

/// Протокол элемента модели погоды
protocol WeatherViewModelItem {
	var type: WeatherViewModelItemType { get }
}

/// Модель отображения погоды
class WeatherViewModel: NSObject {
	/// Айтемы погоды
	var items = [WeatherViewModelItem]()

	init(currentWeather: CurrentWeather){
		super.init()
		let header = HeaderViewModelItem(temp: makeTemp(temp: currentWeather.main.temp),
										 feelsLike: makeTemp(temp: currentWeather.main.feelsLike),
										 desc: currentWeather.weather.first?.weatherDescription.capitalizingFirstLetter() ?? "",
										 iconName: currentWeather.weather.first?.icon ?? "")
		items.append(header)
		let today = TodayViewModelItem(date: makeDate(time: currentWeather.dt,
													  timezone: currentWeather.timezone,
													  format: "dd MMMM"),
									   tempMin: makeTemp(temp: currentWeather.main.tempMin),
									   tempMax: makeTemp(temp: currentWeather.main.tempMax))
		items.append(today)
		let detailItems = makeDetailItems(currentWeather: currentWeather)
		detailItems.forEach { (arg0) in

			let (key, value) = arg0
			let detail = DetailsViewModelItem(title: key, detail: value)
			items.append(detail)
		}
	}

	init(weatherForecast: WeatherForecast) {
		super.init()
		if let timezone = weatherForecast.city.timezone {
			var dayItems: [ForecastViewModelItem] = []
			weatherForecast.list.forEach { (items) in
				let date = makeDate(time: items.dt,
									timezone: timezone,
									format: "dd MMMM")
				let time = makeDate(time: items.dt,
									timezone: timezone,
									format: "HH:00")
				dayItems.append(ForecastViewModelItem(date: date,
													  time: time,
													  temp: makeTemp(temp: items.main.temp),
													  icon: items.weather.first?.icon ?? ""))
			}
			
			items.append(ScrollViewModelItem(items: dayItems))
		}
	}

	private enum WindDirection: String, CaseIterable {
		case north = "С"
		case northWest = "СЗ"
		case west = "З"
		case southWest = "ЮЗ"
		case south = "Ю"
		case southEast = "ЮВ"
		case east = "В"
		case northEast = "СВ"

		init(_ degree: Int) {
			let x = 360/Double(WindDirection.allCases.count)/2
			let y = Double(degree)
			switch (y) {
			case x..<3*x: self = .northWest
			case 3*x..<5*x: self = .west
			case 5*x..<7*x: self = .southWest
			case 7*x..<9*x: self = .south
			case 9*x..<11*x: self = .southEast
			case 11*x..<13*x: self = .east
			case 13*x..<15*x: self = .northEast
			default: self = .north
			}
		}
	}

	private func makeDate(time: Int, timezone: Int, format: String) -> String {
		let date = Date(timeIntervalSince1970: TimeInterval(time))
		let dateFormatter = DateFormatter()
		dateFormatter.locale = .init(identifier: "RU")
		dateFormatter.dateFormat = format
		dateFormatter.timeZone = TimeZone(secondsFromGMT: timezone)
		let localDate = dateFormatter.string(from: date)
		return localDate
	}

	private func makeTemp(temp: Double) -> String {
		let stringTemp = "\(Int(temp)) °C"
		return stringTemp
	}

	private func makePressure(pressure: Int) -> String {
		let doublePressure = ((Double(pressure) * 100) / 1.333).rounded()/100
		let stringPressure = "\(doublePressure) мм рт.ст."
		return stringPressure
	}

	private func makeDetailItems(currentWeather: CurrentWeather) -> Array<(key: String, value: String)> {
		var items: Array<(key: String, value: String)> = []

		let sunrise = makeDate(time: currentWeather.sys.sunrise,
							   timezone: currentWeather.timezone, format: "HH:MM")
		items.append(("Рассвет", sunrise))
		let sunset = makeDate(time: currentWeather.sys.sunset,
							  timezone: currentWeather.timezone, format: "HH:MM")
		items.append(("Закат", sunset))
		items.append(("Давление", makePressure(pressure: currentWeather.main.pressure)))
		items.append(("Влажность", "\(currentWeather.main.humidity) %"))
		items.append(("Видимость", String(format: "%.1f км", Double(currentWeather.visibility / 1000))))
		var windDirection = ""
		if let degree = currentWeather.wind.deg {
			windDirection = WindDirection(degree).rawValue
		}
		let windSpeed = String(format: "%.1f м/с", currentWeather.wind.speed)
		items.append(("Ветер", "\(windDirection) \(windSpeed)" ))
		items.append(("Облачноcть", "\(currentWeather.clouds.all) %"))

		return items
	}
}

/// Заголовочный элемент модели погоды
struct HeaderViewModelItem: WeatherViewModelItem {
	var type: WeatherViewModelItemType {
		return .header
	}

	var temp: String
	var feelsLike: String
	var desc: String
	var iconName: String

	init(temp: String, feelsLike: String, desc: String, iconName: String) {
		self.temp = temp
		self.feelsLike = "Ощущается как \(feelsLike)"
		self.desc = desc
		self.iconName = iconName

	}
}

/// Элемент погоды на сегодня модели погоды
struct TodayViewModelItem: WeatherViewModelItem {
	var type: WeatherViewModelItemType {
		return .today
	}

	var date: String
	var tempMin: String
	var tempMax: String

	init(date: String, tempMin: String, tempMax: String) {
		self.date = date
		self.tempMin = tempMin
		self.tempMax = tempMax
	}
}

/// Элемент дополнительной информации о погоди модели погоды
struct DetailsViewModelItem: WeatherViewModelItem {
	var type: WeatherViewModelItemType {
		return .detail
	}

	var title: String
	var detail: String

	init(title: String, detail: String) {
		self.title = title
		self.detail = detail
	}
}

/// Сводка погоды на каждые 3 часа
struct ForecastViewModelItem {

	var date: String
	var time: String
	var temp: String
	var icon: String

	init(date: String, time: String, temp: String, icon: String) {
		self.date = date
		self.time = time
		self.temp = temp
		self.icon = icon
	}
}

/// Элемент модели погоды хранящий в себе сводку погоды на 5 дней
struct ScrollViewModelItem: WeatherViewModelItem {
	var type: WeatherViewModelItemType {
		return .forecast
	}

	var items: [ForecastViewModelItem]

	init(items: [ForecastViewModelItem]) {
		self.items = items
	}
}
