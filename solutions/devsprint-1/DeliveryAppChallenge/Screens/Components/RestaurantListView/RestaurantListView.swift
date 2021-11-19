//
//  RestaurantListView.swift
//  DeliveryAppChallenge
//
//  Created by Rodrigo Borges on 31/10/21.
//

import UIKit

class RestaurantListView: UIView {
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

    // MARK: Internal

    static let cellSize = CGFloat(82)

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(RestaurantCellView.self, forCellReuseIdentifier: self.cellIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()

    // MARK: Private

    private let cellIdentifier = "RestaurantCellIdentifier"
}

extension RestaurantListView {
    func addSubviews() {
        addSubview(tableView)
    }

    func configureConstraints() {
        NSLayoutConstraint.activate([

            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

// MARK: - UITableViewDataSource

extension RestaurantListView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        dataSource.numberOfRows
        10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? RestaurantCellView
        else {
            return UITableViewCell()
        }

//        let restaurant = dataSource.itemForCell(at: indexPath)
//        cell.configure(restaurant: restaurant)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension RestaurantListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        RestaurantListView.cellSize
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
