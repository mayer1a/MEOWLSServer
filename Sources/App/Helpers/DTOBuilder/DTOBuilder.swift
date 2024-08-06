//
//  DTOBuilder.swift
//
//
//  Created by Artem Mayer on 31.07.2024.
//

import Vapor

struct DTOBuilder {

    // MARK: - User

    static func makeUser(from model: User, with token: Token? = nil) async throws -> User.PublicDTO {
        
        User.PublicDTO(id: try model.requireID(),
                       surname: model.surname,
                       name: model.name,
                       patronymic: model.patronymic,
                       birthday: model.birthday,
                       gender: model.gender,
                       email: model.email,
                       phone: model.phone,
                       token: token?.value,
                       role: model.role)
    }

    // MARK: - Favorites

    static func makeFavorites(from model: Favorites) async throws -> FavoritesDTO {

        let products = try await makeProducts(from: model.products)
        return FavoritesDTO(id: try model.requireID(), products: products?.reversed() ?? [])
    }

    // MARK: - Category

    static func makeCategory(from category: Category?,
                             fullModel: Bool = false,
                             withParent: Bool = true,
                             withImage: Bool = true) throws -> CategoryDTO? {

        guard let category else { return nil }

        var parent: CategoryDTO?
        var image: ImageDTO?

        if fullModel {

            if withParent {
                parent = try makeCategory(from: category.parent,
                                          fullModel: true, 
                                          withParent: false, 
                                          withImage: withImage)
            } else {
                parent = nil
            }

            image = withImage ? makeImage(from: category.image) : nil
        }

        return CategoryDTO(id: try category.requireID(),
                           code: category.code,
                           name: category.name,
                           parent: parent,
                           hasChildren: category.hasChildren,
                           image: image)
    }

    // MARK: - Sale

    static func makeSales(from sales: [Sale]) async throws -> [SaleDTO] {

        try await sales.asyncMap { sale in
            SaleDTO(id: try sale.requireID(),
                    code: sale.code,
                    saleType: sale.saleType,
                    title: sale.title,
                    image: makeImage(from: sale.image),
                    startDate: sale.startDate,
                    endDate: sale.endDate,
                    disclaimer: sale.disclaimer)
        }
    }

    // MARK: - Cart


    // MARK: - Order

}