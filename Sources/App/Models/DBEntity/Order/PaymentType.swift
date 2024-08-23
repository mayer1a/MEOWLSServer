//
//  PaymentType.swift
//  
//
//  Created by Artem Mayer on 25.07.2024.
//

import Vapor

extension Order {

    enum PaymentType: String, Content, CaseIterable {
        
        case card
        case cash

        var description: (title: String, subtitle: String) {
            switch self {
            case .card:
                return (title: "Банковская карта", subtitle: "при получении")

            case .cash:
                return (title: "Наличные", subtitle: "при получении")

            }
        }

    }

}
