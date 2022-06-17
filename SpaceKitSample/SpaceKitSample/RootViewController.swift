//
// Copyright © 2022 Dent Reality. All rights reserved.
//

import UIKit
import SpaceKit

class RootViewController: UIViewController {
	private let spaceKitViewController: UIViewController
	private let spaceKitContext: SpaceKit.Context
	
	var listButtonAction: () -> Void = { }
	
	private lazy var listButton: UIButton = {
		let button = UIButton(type: .custom)
		button.translatesAutoresizingMaskIntoConstraints = false
		let config = UIImage.SymbolConfiguration(pointSize: 32)
		button.setImage(UIImage(systemName: "cart", withConfiguration: config), for: .normal)
		button.addTarget(self, action: #selector(listButtonTapped), for: .primaryActionTriggered)
		button.backgroundColor = .white
		button.setTitleColor(UIColor.systemBlue, for: .normal)
		button.layer.cornerRadius = 10
		button.layer.borderColor = UIColor.gray.cgColor
		button.layer.borderWidth = 1
		button.contentEdgeInsets = .init(top: 8, left: 8, bottom: 8, right: 8)
		return button
	}()
	
	init(spaceKitViewController: UIViewController, spaceKitContext: SpaceKit.Context) {
		self.spaceKitViewController = spaceKitViewController
		self.spaceKitContext = spaceKitContext
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
	
	override func loadView() {
		super.loadView()
		
		addChild(spaceKitViewController)
		view.addSubview(spaceKitViewController.view)
		spaceKitViewController.didMove(toParent: self)
		
		view.addSubview(listButton)
		NSLayoutConstraint.activate([
			listButton.trailingAnchor.constraint(equalTo: view.readableContentGuide.trailingAnchor),
			listButton.topAnchor.constraint(equalTo: view.readableContentGuide.topAnchor),
		])
	}
	
	@objc
	private func listButtonTapped() {
		listButtonAction()
	}
}