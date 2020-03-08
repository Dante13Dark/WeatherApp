//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Yaroslav Tutushkin on 08.03.2020.
//

import UIKit

struct WeatherModel {
	var city: String = ""
	var country: String = ""
	var date: String = ""
	var sunrise: String = ""
	var sunset: String = ""
	var lon: String = ""
	var lat: String = ""
	var temp: String = ""
	var feelsLike: String = ""
	var tempMin: String = ""
	var tempMax: String = ""
	var pressure: String = ""
	var humidity: String = ""
	var visibility: String = ""
	var windSpeed: String = ""
	var windDeg: String = ""
	var clouds: String = ""
	var desc: String = ""
	var icon: UIImage = UIImage()

	init(currentWeather: CurrentWeather) {
		city = currentWeather.name
		country = currentWeather.sys.country
		date = makeDate(time: currentWeather.dt, timezone: currentWeather.timezone, format: "dd MMMM yyyy")
		sunrise = makeDate(time: currentWeather.sys.sunrise, timezone: currentWeather.timezone, format: "HH:MM")
		sunset = makeDate(time: currentWeather.sys.sunset, timezone: currentWeather.timezone, format: "HH:MM")
		lat = "\(currentWeather.coord.lat)"
		lon = "\(currentWeather.coord.lon)"

		temp = makeTemp(temp: currentWeather.main.temp)
		feelsLike = makeTemp(temp: currentWeather.main.feelsLike)
		tempMin = makeTemp(temp: currentWeather.main.tempMin)
		tempMax = makeTemp(temp: currentWeather.main.tempMax)
		pressure = makePressure(pressure: currentWeather.main.pressure)
		humidity = "\(currentWeather.main.humidity) %"
		visibility = String(format: "%.1f км", Double(currentWeather.visibility / 1000))
		windSpeed = String(format: "%.1f м/с", currentWeather.wind.speed)
		windDeg = WindDirection(currentWeather.wind.deg).rawValue
		clouds = "\(currentWeather.clouds.all) %"
		desc = currentWeather.weather.first?.weatherDescription.capitalized ?? ""
		if let iconName = currentWeather.weather.first?.icon,
			let icon = UIImage(named: iconName) {
			self.icon = icon
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
			case .northWest: return 24...68
			case .west: return 69...113
			case .southWest: return 114...158
			case .south: return 159...203
			case .southEast: return 204...248
			case .east: return 249...293
			case .northEast: return 294...338
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
}
