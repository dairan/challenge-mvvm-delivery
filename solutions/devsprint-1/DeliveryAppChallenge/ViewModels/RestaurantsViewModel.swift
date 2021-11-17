//
//  RestaurantsViewModel.swift
//  DeliveryAppChallenge
//
//  Created by Dairan on 09/11/21.
//

import Foundation

protocol RestaurantsViewModelDelegate: AnyObject {
    func startedDownload()
    func successedDownload()
    func failedDownload()
}

class RestaurantsViewModel {

    weak var delegate: RestaurantsViewModelDelegate?

    private let repository: DeliveryApi

    // MARK: Lifecycle

    init(repository: DeliveryApi = DeliveryApi()) {
        self.repository = repository
        fetchData()
    }

    // MARK: Internal

    var bindViewModelUpdated: (() -> Void)?

    private(set) var restaurants: [Restaurant] = [] {
        didSet {
            bindViewModelUpdated?()
        }
    }

    var numberOfRows: Int {
        return restaurants.count
    }

    func itemForCell(at index: IndexPath) -> RestaurantCell {
        let restaurants = restaurants[index.row]
        return RestaurantCell(restaurant: restaurants)
    }

    // MARK: Private

    private func fetchData() {
        delegate?.startedDownload()
        repository.fetchRestaurants { [weak self] result in
            guard let self = self else { return }
            
            switch result {
                case let .success(restaurants):
                    self.restaurants = restaurants
                    self.delegate?.successedDownload()
                case let .failure(error):
                    print(error)
                    self.delegate?.failedDownload()
            }
        }
    }
}

// MARK: - RestaurantCell

struct RestaurantCell {
    let restaurant: Restaurant

    var title: String {
        restaurant.name
    }

    var description: String {
        "\(restaurant.category) • \(restaurant.deliveryTime.min)-\(restaurant.deliveryTime.max) min"
    }
}
