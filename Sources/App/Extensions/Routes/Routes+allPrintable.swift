//
//  Routes+allPrintable.swift
//
//
//  Created by Artem Mayer on 29.06.2024.
//

import Vapor

public extension Routes {

    /// Format print all routes if DEBUG
    func print() {
        #if DEBUG
            Swift.print(allPrintable)
        #endif
    }

    private var allPrintable: String {
        var get = ""
        var post = ""
        var patch = ""
        var delete = ""
        var other = ""

        all.forEach { route in
            switch route.method {
            case .GET:
                let description = route.description.dropFirst(4)
                get += get.isEmpty ? "\n[ GET ]:\n\t\(description)" : "\n\t\(description)"

            case .POST:
                let description = route.description.dropFirst(5)
                post += post.isEmpty ? "\n[ POST ]:\n\t\(description)" : "\n\t\(description)"

            case .PATCH:
                let description = route.description.dropFirst(6)
                patch += patch.isEmpty ? "\n[ PATCH ]:\n\t\(description)" : "\n\t\(description)"

            case .DELETE:
                let description = route.description.dropFirst(7)
                delete += delete.isEmpty ? "\n[ DELETE ]:\n\t\(description)" : "\n\t\(description)"

            default:
                other += other.isEmpty ? "\n[ OTHER ]:\n\t\(route.description)" : "\n\t\(route.description)"

            }
        }
        let header = "\n\n------------------ [ ALL ROUTES ] ------------------"
        let footer = "\n----------------------------------------------------\n\n"
        return "\(header)\(get)\(post)\(patch)\(delete)\(other)\(footer)"
    }

}
