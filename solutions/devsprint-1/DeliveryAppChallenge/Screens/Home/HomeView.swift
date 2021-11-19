//
//  HomeView.swift
//  DeliveryAppChallenge
//
//  Created by Rodrigo Borges on 31/10/21.
//

import UIKit

final class HomeView: UIView {
    // MARK: Lifecycle

    init() {
        super.init(frame: .zero)

        backgroundColor = .white

        addSubviews()
        configureConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Private

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 0
        return stackView
    }()

    private let addressView: AddressView = {
        let addressView = AddressView()
        addressView.translatesAutoresizingMaskIntoConstraints = false
        return addressView
    }()

    private let categoryListView: CategoryListView = {
        let categoryListView = CategoryListView()
        categoryListView.translatesAutoresizingMaskIntoConstraints = false
        return categoryListView
    }()

    let restaurantListView: RestaurantListView = {
        let restaurantListView = RestaurantListView()
        restaurantListView.translatesAutoresizingMaskIntoConstraints = false
        return restaurantListView
    }()
}

extension HomeView {
    private func addSubviews() {
        addSubview(scrollView)
        scrollView.addSubview(stackView)

        stackView.addArrangedSubview(addressView)
        stackView.addArrangedSubview(categoryListView)
        stackView.addArrangedSubview(restaurantListView)
    }

    private func configureConstraints() {
//        let estimatedHeight = CGFloat(restaurantListView.tableView.numberOfRows(inSection: 0)) * RestaurantListView.cellSize

        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),

            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
//            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),

            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

//            restaurantListView.heightAnchor.constraint(equalToConstant: estimatedHeight),
            restaurantListView.heightAnchor.constraint(equalToConstant: 1000),
            restaurantListView.topAnchor.constraint(equalTo: categoryListView.bottomAnchor),
            restaurantListView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            restaurantListView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            restaurantListView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
        ])
    }
}
