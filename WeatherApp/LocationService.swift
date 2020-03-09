//
//  LocationService.swift
//  WeatherApp
//
//  Created by Yaroslav Tutushkin on 02.03.2020.
//

import CoreLocation

final class LocationService: NSObject {

	private var needUpdate: Bool = false
	// MARK: Location

	let locationManager = CLLocationManager()

	weak var output: LocationServiceOutput?

	override init() {
		super.init()
		locationManager.delegate = self
		print("CURRENT LOCATION STATUS = \(CLLocationManager.authorizationStatus().rawValue)")
		locationManager.requestWhenInUseAuthorization()
	}
}

extension LocationService: LocationServiceInput {
	func getCoord() {
		if (CLLocationManager.authorizationStatus() == .authorizedWhenInUse || CLLocationManager.authorizationStatus() == .authorizedAlways) {
			print("DELEGATE REQUEST LOCATION")
			needUpdate = true
			locationManager.requestLocation()
		}
	}
}
extension LocationService: CLLocationManagerDelegate {

	func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
		print("location manager authorization status changed to \(status.rawValue)")
	}

	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		if let location = locations.first {
			let coord = Coord(lat: location.coordinate.latitude, lon: location.coordinate.longitude)
			print("ЛОКАЦИЯ БЫЛА ОБНОВЛЕНА НА \(coord.lat) \(coord.lon)")
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
