//
//  LoadingView.swift
//  WeatherApp
//
//  Created by Yaroslav Tutushkin on 27.02.2020.
//

import Foundation
import UIKit

/// Лоадер
final class Loader {

	var blurImg = UIImageView()
	var indicator = UIActivityIndicatorView()

	init() {
		blurImg.frame = UIScreen.main.bounds
		blurImg.backgroundColor = UIColor.black
		blurImg.isUserInteractionEnabled = true
		blurImg.alpha = 0.5
		indicator.style = .whiteLarge
		indicator.center = blurImg.center
		indicator.startAnimating()
		indicator.color = .red
	}

	private func showIndicator() {
		DispatchQueue.main.async {
			UIApplication.shared.keyWindow?.addSubview(self.blurImg)
			UIApplication.shared.keyWindow?.addSubview(self.indicator)
		}
	}

	private func hideIndicator() {

		DispatchQueue.main.async {
			self.blurImg.removeFromSuperview()
			self.indicator.removeFromSuperview()
		}
	}
}

extension Loader: LoaderProtocol {
	func set(loaderIsHidden: Bool) {
		loaderIsHidden ? hideIndicator() : showIndicator()
	}
}

protocol LoaderProtocol {
	/// Изменить состояние лоадера
	func set(loaderIsHidden: Bool)
}
