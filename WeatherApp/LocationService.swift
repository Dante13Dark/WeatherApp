//
//  LocationService.swift
//  WeatherApp
//
//  Created by Yaroslav Tutushkin on 02.03.2020.
//

import CoreLocation

final class LocationService: NSObject {
	// MARK: Location

	let locationManager = CLLocationManager()

	weak var output: LocationServiceProtocol?

	override init() {
		super.init()
		locationManager.delegate = self

		locationManager.requestWhenInUseAuthorization()
		if (CLLocationManager.authorizationStatus() == .authorizedWhenInUse || CLLocationManager.authorizationStatus() == .authorizedAlways) {
			locationManager.requestLocation()
		}
	}
}

extension LocationService: CLLocationManagerDelegate {

	func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
		print("location manager authorization status changed")
	}

	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		if let location = locations.first {
			let coord = Coord(lat: location.coordinate.latitude, lon: location.coordinate.longitude)
			print("ЛОКАЦИЯ БЫЛА ОБНОВЛЕНА НА \(coord.lat) \(coord.lon)")
			output?.didUpdate(coord: coord)
		}
	}

	func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
		print(error.localizedDescription)
	}
}
