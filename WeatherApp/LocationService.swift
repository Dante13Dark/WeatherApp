//
//  LocationService.swift
//  WeatherApp
//
//  Created by Yaroslav Tutushkin on 02.03.2020.
//

import CoreLocation

/// Сервис геолокации
final class LocationService: NSObject {
	/// Внутренний параметр, нужный для запроса данных по требованию
	private var needUpdate: Bool = false
	/// Менеджер локации
	let locationManager = CLLocationManager()
	/// Обработчик данных от сервиса геолокации
	weak var output: LocationServiceOutput?

	override init() {
		super.init()
		locationManager.delegate = self
		locationManager.requestWhenInUseAuthorization()
	}
}

extension LocationService: LocationServiceInput {
	func getCoord() {
		needUpdate = true
		if (CLLocationManager.authorizationStatus() == .authorizedWhenInUse || CLLocationManager.authorizationStatus() == .authorizedAlways) {
			locationManager.requestLocation()
		}
	}
}
extension LocationService: CLLocationManagerDelegate {

	func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
		// Нужно для получения геопозиции в первый раз
		if needUpdate {
			locationManager.requestLocation()
		}
	}

	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		if let location = locations.first {
			let coord = Coord(lat: location.coordinate.latitude, lon: location.coordinate.longitude)
			if needUpdate {
				needUpdate = false
				output?.didUpdate(coord: coord)
			}
		}
	}

	func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
		print(error.localizedDescription)
	}
}
