//
//  SummaryType.swift
//  
//
//  Created by Artem Mayer on 20.08.2024.
//

import Vapor

enum SummaryType: String, Content, CaseIterable {

    case itemsWithoutDiscount = "ITEMS_WITHOUT_DISCOUNT"
    case discount = "DISCOUNT"
    case promoDiscount = "PROMO_DISCOUNT"
    case delivery = "DELIVERY"
    case total = "TOTAL"

    var description: String {
        switch self {
        case .itemsWithoutDiscount: return "Товары без скидки"
        case .discount: return "Размер скидки"
        case .promoDiscount: return "Промокод"
        case .delivery: return "Доставка"
        case .total: return "Итого:"
        }
    }

}
