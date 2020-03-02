//
//  StartViewController.swift
//  WeatherApp
//
//  Created by Yaroslav Tutushkin on 29.02.2020.
//

import UIKit

class StartViewController: UIPageViewController
{
	// Properties
	var pages: [UIViewController] = []

	let bottomButton: UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.layer.cornerRadius = 15
		button.backgroundColor = .white
		button.setTitle("Список городов", for: .normal)
		button.setTitleColor(.black, for: .normal)
		button.addTarget(self, action: #selector(action), for: .touchUpInside)
		return button
	}()

	var currentIndex: Int = 0

	// презентер экрана
	var output: StartViewOutput

	init(output: StartViewOutput) {
		self.output = output
		super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
	}

	// Заглушка для обязательного инициализатора без реализации.
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}


	override func viewDidLoad()
	{
		super.viewDidLoad()
		self.dataSource = self
		self.delegate = self
		view.backgroundColor = .cyan
		view.addSubview(bottomButton)
		setupLayout()
		setupButton()
		output.didLoad()
	}

	override var viewControllers: [UIViewController]? {
		get { return pages }
		set { pages = newValue ?? [] }
	}

	func setupButton() {
		let button = UIBarButtonItem(image: UIImage(named: "10d"), style: .plain,
									 target: self, action: #selector(action))
		navigationItem.rightBarButtonItem  = button
	}

	@objc func action() {
		let vc = ListOfCitiesViewController(nibName: nil, bundle: nil)
//		vc.savedCities = savedArray
		navigationController?.pushViewController(vc, animated: true)
	}

	func setupLayout() {
		NSLayoutConstraint.activate([
			bottomButton.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
			bottomButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			bottomButton.heightAnchor.constraint(equalToConstant: 50)
			])
	}
}

extension StartViewController: StartViewInput {}

extension StartViewController: PageDelegate {

	func currentVC(viewController: WeatherViewController) {
		guard let viewControllerIndex = pages.firstIndex(of: viewController) else { return }
		currentIndex = viewControllerIndex
		print("CURRENT INDEX = \(currentIndex)")
	}
}

extension StartViewController: UIPageViewControllerDelegate { }

extension StartViewController: UIPageViewControllerDataSource
{
	func pageViewController(_ StartViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {

		guard let viewControllerIndex = pages.firstIndex(of: viewController) else { return nil }

		let previousIndex = viewControllerIndex - 1

		guard previousIndex >= 0 else {
			return pages.last
		}

		guard pages.count > previousIndex else { return nil }

		return pages[previousIndex]
	}

	func pageViewController(_ StartViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController?
	{
		guard let viewControllerIndex = pages.firstIndex(of: viewController) else { return nil }

		let nextIndex = viewControllerIndex + 1

		guard nextIndex < pages.count else {

			return pages.first
		}

		guard pages.count > nextIndex else { return nil }

		return pages[nextIndex]
	}
}
