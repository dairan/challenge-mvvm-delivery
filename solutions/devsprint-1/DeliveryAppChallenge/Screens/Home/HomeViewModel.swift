//
//  HomeViewModel.swift
//  DeliveryAppChallenge
//
//  Created by Dairan on 14/11/21.
//

import Foundation
import UIKit


// MARK: - HomeViewModel

final class HomeViewModel {
    // MARK: Lifecycle

    init(repository: DeliveryApi = DeliveryApi()) {
        self.repository = repository
    }

    // MARK: Internal

    let repository: DeliveryApi
    var bindUpdated: (() -> Void)?

    private(set) var restaurants: [Restaurant] = [] {
        didSet { bindUpdated?() }
    }

    func fetchRestaurats() {
        repository.fetchRequest(urlString: .homeRestaurantList, method: .get) { (result: Result<[Restaurant], DeliveryApiError>) in
            switch result {
                case let .success(success):
                    self.restaurants = success
                case let .failure(failure):
                    print("==4===:  failure", failure)
            }
        }
    }
}
