//
//  HomeVM.swift
//  PickmeSample-Anushka
//
//  Created by Anushka Samarasinghe on 2025-07-31.
//

import Foundation
import Observation

enum HomeSection {
    case rides
    case food
    case market
    
    var title: String {
        switch self {
        case .rides:
            return "Rides"
        case .food:
            return "Food"
        case .market:
            return "Market"
        }
    }
    
    var Image: String {
        switch self {
        case .rides:
            return "Ride"
        case .food:
            return "Food"
        case .market:
            return "Market"
        }
    }
}

@Observable
final class HomeVM {
    var homeSection: [HomeSection] = [.rides, .food, .market]
    
}
