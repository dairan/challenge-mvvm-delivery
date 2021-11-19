//
//  ViewController.swift
//  DeliveryAppChallenge
//
//  Created by Rodrigo Borges on 25/10/21.
//

import UIKit

// MARK: - HomeViewController

class HomeViewController: UIViewController {
    // MARK: Lifecycle

    init() {
        super.init(nibName: nil, bundle: nil)

        navigationItem.title = "Delivery App"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Settings",
                                                            style: .plain,
                                                            target: nil,
                                                            action: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Internal

    lazy var viewModel = HomeViewModel()

    override func viewDidLoad() {
        navigationController?.navigationBar.prefersLargeTitles = true

        viewModel.fetchRestaurats()
        viewModel.bindUpdated = {
            print("==56===:  self.viewModel.restaurants", self.viewModel.restaurants)
        }
    }

    override func loadView() {
        self.view = homeView
    }

    // MARK: Private

    private let homeView: HomeView = {
        let view = HomeView()
        return view
    }()
}
