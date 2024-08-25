//
//  StatusCode.swift
//
//
//  Created by Artem Mayer on 25.07.2024.
//

import Vapor

extension Order {

    enum StatusCode: String, Content {
        
        case canceled = "CANCELED"
        case completed = "COMPLETED"
        case inProgress = "IN_PROGRESS"

        func getStatus() -> String {

            switch self {
            case .canceled:
                return "Отменен"

            case .completed:
                return "Выполнен"

            case .inProgress:
                return "Новый"
            }
        }

    }

}
