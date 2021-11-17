//
//  HomeViewModel.swift
//  DeliveryAppChallenge
//
//  Created by Dairan on 14/11/21.
//

import Foundation

final class HomeViewModel {
    let restauratsList: [Restaurant]

    init(restaurants: [Restaurant]) {
        self.restauratsList = restaurants
    }
}
