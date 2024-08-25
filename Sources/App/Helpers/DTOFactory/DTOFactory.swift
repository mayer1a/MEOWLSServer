//
//  DTOFactory.swift
//
//
//  Created by Artem Mayer on 31.07.2024.
//

import Vapor

struct DTOFactory {

    typealias SQLRawResponse = SearchRepository.SQLRawResponse

    // MARK: - User

    static func makeUser(from model: User, with token: Token? = nil, fullModel: Bool = true) throws -> User.PublicDTO {

        var userBuilder = UserPublicBuilder()
            .setSurname(model.surname)
            .setName(model.name)
            .setPatronymic(model.patronymic)
            .setEmail(model.email)
            .setPhone(model.phone)

        if fullModel {
            userBuilder = userBuilder
                .setId(try model.requireID())
                .setBirthday(model.birthday)
                .setGender(model.gender)
        }

        if let token {
            userBuilder = userBuilder.setAuthentication(Authentication(token: token.value, expiresAt: token.expired))
        }

        return try userBuilder.build()
    }

    // MARK: - Favorites

    static func makeFavorites(from model: Favorites) throws -> FavoritesDTO {

        let products = try makeProducts(from: model.products)
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

    static func makeSales(from sales: [Sale]) throws -> [SaleDTO] {

        try sales.map { sale in

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

}
