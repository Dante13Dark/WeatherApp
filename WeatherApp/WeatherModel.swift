//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Yaroslav Tutushkin on 08.03.2020.
//

import UIKit

enum WeatherViewModelItemType {
	case header
	case detail
	case today
}

protocol WeatherViewModelItem {
	var type: WeatherViewModelItemType { get }
	var rowCount: Int { get }
}

class WeatherViewModel: NSObject {
	var items = [WeatherViewModelItem]()

	init(currentWeather: CurrentWeather){
		super.init()
		let header = HeaderViewModelItem(temp: makeTemp(temp: currentWeather.main.temp),
									 feelsLike: makeTemp(temp: currentWeather.main.feelsLike),
									 desc: currentWeather.weather.first?.weatherDescription.capitalized ?? "")
		items.append(header)
		let today = TodayViewModelItem(date: makeDate(time: currentWeather.dt,
												  timezone: currentWeather.timezone,
												  format: "dd MMMM yyyy"),
								   tempMin: makeTemp(temp: currentWeather.main.tempMin),
								   tempMax: makeTemp(temp: currentWeather.main.tempMax),
								   iconName: currentWeather.weather.first?.icon ?? "")
		items.append(today)
		let detailItems = makeDetailItems(currentWeather: currentWeather)
		detailItems.forEach { (arg0) in

			let (key, value) = arg0
			let detail = DetailsViewModelItem(title: key, detail: value)
			items.append(detail)
		}
	}

	private enum WindDirection: String {
		case north = "С"
		case northWest = "СЗ"
		case west = "З"
		case southWest = "ЮЗ"
		case south = "Ю"
		case southEast = "ЮВ"
		case east = "В"
		case northEast = "СВ"

		var range: CountableClosedRange<Int> {
			switch self {
			case .northWest: return 23...67
			case .west: return 68...112
			case .southWest: return 113...157
			case .south: return 158...202
			case .southEast: return 203...247
			case .east: return 248...292
			case .northEast: return 293...337
			case .north: return 0...360
			}
		}

		init(_ degree: Int) {
			switch (degree) {
			case WindDirection.northWest.range: self = .northWest
			case WindDirection.west.range: self = .west
			case WindDirection.southWest.range: self = .southWest
			case WindDirection.south.range: self = .south
			case WindDirection.southEast.range: self = .southEast
			case WindDirection.east.range: self = .east
			case WindDirection.northEast.range: self = .northEast
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
		items.append(("Скорость ветра", String(format: "%.1f м/с", currentWeather.wind.speed)))
		items.append(("Направление ветра", WindDirection(currentWeather.wind.deg).rawValue))
		items.append(("Облачноть", "\(currentWeather.clouds.all) %"))

		return items
	}
}

struct HeaderViewModelItem: WeatherViewModelItem {
	var type: WeatherViewModelItemType {
		return .header
	}

	var rowCount: Int {
		return 1
	}

	var temp: String
	var feelsLike: String
	var desc: String

	init(temp: String, feelsLike: String, desc: String) {
		self.temp = temp
		self.feelsLike = "Ощущается как \(feelsLike)"
		self.desc = desc
	}
}

struct TodayViewModelItem: WeatherViewModelItem {
	var type: WeatherViewModelItemType {
		return .today
	}

	var rowCount: Int {
		return 1
	}

	var date: String
	var tempMin: String
	var tempMax: String
	var iconName: String

	init(date: String, tempMin: String, tempMax: String, iconName: String) {
		self.date = date
		self.tempMin = tempMin
		self.tempMax = tempMax
		self.iconName = iconName
	}
}

struct DetailsViewModelItem: WeatherViewModelItem {
	var type: WeatherViewModelItemType {
		return .detail
	}

	var rowCount: Int {
		return 1
	}

	var title: String
	var detail: String

	init(title: String, detail: String) {
		self.title = title
		self.detail = detail
	}
}
