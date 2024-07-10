//
//  MockProductsReviews.swift
//
//
//  Created by Artem Mayer on 28.03.2023.
//

import Vapor

typealias ReviewId = Int

final class MockProductsReviews {

    // MARK: - Functions

    func addReview(_ review: AddReviewRequest) -> Int {
        let lastId = reviews.last?.review_id
        let nextId = lastId != nil ? lastId! + 1 : 100

        let review = Review(
            review_id: nextId,
            product_id: review.product_id,
            user_id: review.user_id,
            rating: review.rating,
            date: review.date,
            body: review.body)

        reviews.append(review)

        return nextId
    }

    @discardableResult
    func approveReview(id: ReviewId) -> Bool {
        guard isReviewExists(id: id), !isApprovedReview(id: id) else {
            return false
        }

        approvedReviews.append(id)
        return true
    }

    func deleteReview(id: ReviewId) {
        reviews.removeAll { $0.review_id == id }
    }

    func getReview(id: ReviewId) -> Review? {
        reviews.first { $0.review_id == id }
    }

    func getReviews(productId: Int) -> [Review] {
        reviews.compactMap { review in review.product_id == productId ? review : nil }
    }

    func isReviewExists(id: ReviewId) -> Bool {
        reviews.contains { $0.review_id == id }
    }

    func isReviewExists(_ model: AddReviewRequest) -> Bool {
        guard let userId = model.user_id else { return false }

        return reviews.contains { review in
            review.product_id == model.product_id && review.body == model.body && review.user_id == userId
        }
    }

    func isApprovedReview(id: ReviewId) -> Bool {
        approvedReviews.contains { $0 == id }
    }

    // MARK: - Private properties

    private var approvedReviews: [ReviewId] = []

    private var reviews: [Review] = [
        Review(
            review_id: 101,
            product_id: 18320,
            rating: 5,
            date: 1671329735,
            body: "Отличный корм для моего питомца. Заметил, что шерсть стала гуще и блестящей."),
        Review(
            review_id: 102,
            product_id: 24055,
            rating: 4,
            date: 1674296775,
            body: "Хороший корм, но моему коту не сильно нравится запах."),
        Review(
            review_id: 103,
            product_id: 16281,
            rating: 4,
            date: 1664434242,
            body: "Хороший корм, кот ест с удовольствием. Но цена немного высокая."),
        Review(
            review_id: 104,
            product_id: 12356,
            rating: 5,
            date: 1669963208,
            body: "Любимый корм моих котов. Они не желают есть ничего другого."),
        Review(
            review_id: 105,
            product_id: 26196,
            rating: 3,
            date: 1668109913,
            body: "Корм неплохой, но мне кажется, что не соответствует своей цене."),
        Review(
            review_id: 106,
            product_id: 23019,
            rating: 5,
            date: 1670804616,
            body: "Очень доволен кормом для моей собаки. У него крепкие зубы и здоровое пищеварение."),
        Review(
            review_id: 107,
            product_id: 18320,
            rating: 4,
            date: 1676743606,
            body: "Хороший корм. Но хотелось бы больше мяса и меньше зерна в составе."),
        Review(
            review_id: 108,
            product_id: 16719,
            rating: 4,
            date: 1667273245,
            body: "Корм понравился, но у моего питомца появилась аллергия после того, как я начал его кормить."),
        Review(
            review_id: 109,
            product_id: 24055,
            rating: 5,
            date: 1678542251,
            body: "Дорогой корм, но стоит каждого цента. У моей кошки отличное здоровье."),
        Review(
            review_id: 110,
            product_id: 24170,
            rating: 4,
            date: 1674221976,
            body: "Корм нравится моему псу. Но я периодически обнаруживаю кусочки зерна в его миске, хотелось бы, чтобы такого не было."),
        Review(
            review_id: 111,
            product_id: 26196,
            rating: 5,
            date: 1669222182,
            body: "Отличный корм! Мой кот съедает каждую крошку."),
        Review(
            review_id: 112,
            product_id: 24055,
            rating: 4,
            date: 1670056544,
            body: "Неплохой корм, но куски мяса немного мелкие."),
        Review(
            review_id: 113,
            product_id: 4793,
            rating: 3,
            date: 1678129264,
            body: "Цена выше средней, а качество на уровне обычных сухих кормов."),
        Review(
            review_id: 114,
            product_id: 24055,
            rating: 5,
            date: 1676357584,
            body: "Моя собака его обожает. Как только я его достаю из шкафа, она начинает прыгать от радости."),
        Review(
            review_id: 115,
            product_id: 12356,
            rating: 4,
            date: 1664148549,
            body: "Хороший состав корма, но стоимость несколько перебивает меня с толку."),
        Review(
            review_id: 116,
            product_id: 15236,
            rating: 5,
            date: 1668589933,
            body: "Отличный корм для моего котенка. Он научился есть только этот корм."),
        Review(
            review_id: 117,
            product_id: 16719,
            rating: 3,
            date: 1669643847,
            body: "Ожидал большего от этого корма. Надеялся, что улучшится состояние моего питомца, но ничего не изменилось."),
        Review(
            review_id: 118,
            product_id: 24055,
            rating: 4,
            date: 1674007676,
            body: "Мне кажется, что кусочки мяса в корме немного маленькие. Но мой питомец ест со вкусом."),
        Review(
            review_id: 119,
            product_id: 16281,
            rating: 5,
            date: 1670780342,
            body: "Супер корм! Моя кошка получила новую жизнь после того, как мы начали ей давать его."),
        Review(
            review_id: 120,
            product_id: 12356,
            rating: 3,
            date: 1672977739,
            body: "Корм недостаточно мясистый. Но цена вполне оправдана."),
        Review(
            review_id: 121,
            product_id: 26196,
            rating: 5,
            date: 1662754964,
            body: "На мой взгляд, этот корм - лучший в своей категории. Мой собака также этого мнения."),
        Review(
            review_id: 122,
            product_id: 18320,
            rating: 4,
            date: 1679822888,
            body: "Хороший корм, но стойкой запах корма порой доставляет неудобства."),
        Review(
            review_id: 123,
            product_id: 24055,
            rating: 5,
            date: 1675710534,
            body: "Отличный корм для моей кошки. Я всегда знаю, что она получает все необходимые витамины и минералы."),
        Review(
            review_id: 124,
            product_id: 4793,
            rating: 4,
            date: 1677282146,
            body: "Корм действительно хороший, но он немного дорогой. Можно было бы понизить цену на несколько рублей."),
        Review(
            review_id: 125,
            product_id: 12356,
            rating: 5,
            date: 1666352233,
            body: "Этот корм - просто находка для моего питомца. Он очень крепок и здоров."),
        Review(
            review_id: 126,
            product_id: 15236,
            rating: 3,
            date: 1673746337,
            body: "Я оцениваю качество этого корма и признаю, что он хорошо усваивается питомцем. Однако, он, к сожалению, не смог предотвратить заболевание моего кота. Я продолжу использовать его в качестве дополнения к лечению, но не рассчитываю на него как на единственное средство лечения."),
        Review(
            review_id: 127,
            product_id: 26196,
            rating: 4,
            date: 1667331157,
            body: "Несмотря на то, что у меня были некоторые сомнения по поводу состава, мой питомец стал едать этот корм без проблем, и его здоровье улучшилось. Я рада, что попробовала этот корм для своего питомца, несмотря на некоторые предварительные сомнения. Благодаря ему я получила заметные улучшения в здоровье своего питомца и уверенность в качестве его питания."),
        Review(
            review_id: 128,
            product_id: 24055,
            rating: 5,
            date: 1677859520,
            body: "Корм реально крут! Мой кот начал гораздо лучше регулировать свой вес после того, как мы начали давать ему этот корм."),
        Review(
            review_id: 129,
            product_id: 16719,
            rating: 4,
            date: 1665245619,
            body: "Хороший корм, но иногда мой питомец не хочет есть его."),
        Review(
            review_id: 130,
            product_id: 16719,
            rating: 5,
            date: 1676135735,
            body: "Мои питомцы обожают этот корм! Они просто кушают его как обалденные. Я очень довольна качеством данного корма. Это действительно высококачественный продукт, который мои питомцы едят с удовольствием.")
    ]
}
