//
//  StartPresenterInputSpy.swift
//  WeatherAppTests
//
//  Created by Yaroslav Tutushkin on 09.03.2020.
//

@testable import WeatherApp

final class StartPresenterInputSpy {
	private(set) var presentedModel: PresentationModel<Model>?
}

extension StartPresenterInputSpy: StartPresenterInput {
	func present(model: PresentationModel<Model>) {
		presentedModel = model
	}
}
