//
//  ViewController.swift
//  DeliveryAppChallenge
//
//  Created by Rodrigo Borges on 25/10/21.
//

import UIKit

// MARK: - HomeViewController

class HomeViewController: UIViewController {
    init() {
        super.init(nibName: nil, bundle: nil)

        navigationItem.title = "Delivery App"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Settings",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(obterDadosDidTap))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        navigationController?.navigationBar.prefersLargeTitles = true
//        RestaurantsViewModel()
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

extension HomeViewController {
    @objc
    private func obterDadosDidTap() {
        let dataSource = RestaurantsViewModel()
        dataSource.bindViewModelUpdated = { [weak self] in
            guard let self = self else { return }
//            self.homeView.restaurantListView.configure(dataSource: dataSource)
        }
    }
}
