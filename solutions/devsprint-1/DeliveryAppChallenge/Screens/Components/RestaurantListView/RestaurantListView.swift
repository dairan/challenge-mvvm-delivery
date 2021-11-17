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
        dataSource.bindViewModelUpdated = {
            self.tableView.reloadData()
//            self.configureConstraints()
        }
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
        tableView.backgroundView = activityIndicator
        tableView.refreshControl = refresherControl
        return tableView
    }()

    func configure(dataSource: RestaurantsViewModel) {
        self.dataSource = dataSource
//        dataSource.delegate = self
    }

    @objc
    func update() {
        let dataSource = RestaurantsViewModel()
        self.dataSource = dataSource
        dataSource.delegate = self
    }

    // MARK: Private

    private lazy var activityIndicator: UIActivityIndicatorView = {
        let ai = UIActivityIndicatorView()
        ai.translatesAutoresizingMaskIntoConstraints = false
        ai.hidesWhenStopped = true
        ai.startAnimating()
        return ai
    }()

    lazy var refresherControl: UIRefreshControl = {
        let refresher = UIRefreshControl()
//        refresher.target(forAction: #selector(update), withSender: self)
        refresher.addTarget(self, action: #selector(update), for: .valueChanged)
        refresher.attributedTitle = NSAttributedString("Puxe para atualizar")
        return refresher
    }()

    private let cellIdentifier = "RestaurantCellIdentifier"
    private lazy var dataSource: RestaurantsViewModel = {
        let dataSource = RestaurantsViewModel()
        dataSource.delegate = self
        return dataSource
    }()

    private func startActivityAnimation() {
//        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }

    private func stopActivityAnimation() {
//        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
    }
}

extension RestaurantListView {
    func addSubviews() {
//        addSubview(activityIndicator)
        addSubview(tableView)
//        refresherControl = refresherControl
    }

    func configureConstraints() {
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: tableView.centerXAnchor),
            activityIndicator.topAnchor.constraint(equalTo: tableView.topAnchor, constant: 200),

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
        dataSource.numberOfRows
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? RestaurantCellView
        else {
            return UITableViewCell()
        }

        let restaurant = dataSource.itemForCell(at: indexPath)
        cell.configure(restaurant: restaurant)

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

// MARK: - RestaurantsViewModelDelegate

extension RestaurantListView: RestaurantsViewModelDelegate {
    func startedDownload() {
        startActivityAnimation()
    }

    func successedDownload() {
        stopActivityAnimation()
    }

    func failedDownload() {
    }
}
