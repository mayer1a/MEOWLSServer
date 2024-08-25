//
//  PayOrderJob+JobData.swift
//
//
//  Created by Artem Mayer on 24.08.2024.
//

import Foundation

extension PayOrderJob {

    struct JobData: Codable {

        let orderNumber: Int

        init(orderNumber: Int) {
            self.orderNumber = orderNumber
        }

        init?(orderNumber: String) {
            guard let stringNumber = Int(orderNumber) else { return nil }
            self.orderNumber = stringNumber
        }

    }

}
