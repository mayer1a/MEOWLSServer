//
//  MockProducts.swift
//
//
//  Created by Artem Mayer on 25.03.2023.
//

import Vapor

struct MockProducts {

    // MARK: - Properties

    static let shared = MockProducts()

    let products: [Product] = [
        Product(
            product_id: 23019,
            product_name: "Grandorf Adult Indoor Белая рыба/бурый рис для кошек 2 кг.",
            product_category: "СУПЕРПРЕМИУМ СУХОЙ КОРМ ДЛЯ КОШЕК",
            product_price: 2378,
            product_main_image: "https://cdn.mokryinos.ru/images/site/catalog/480x480/2_17618_1675935990.webp"),
        Product(
            product_id: 16719,
            product_name: "Grandorf Kitten Ягненок/рис для котят 2 кг.",
            product_category: "СУПЕРПРЕМИУМ СУХОЙ КОРМ ДЛЯ КОШЕК",
            product_price: 2378,
            product_main_image: "https://cdn.mokryinos.ru/images/site/catalog/480x480/2_17622_1606105053.webp"),
        Product(
            product_id: 18320,
            product_name: "Farmina N&D Ancestral Grain Neutered Курица/Гранат (низ/зерн) для кошек",
            product_category: "СУПЕРПРЕМИУМ СУХОЙ КОРМ ДЛЯ КОШЕК",
            product_price: 1858,
            product_main_image: "https://cdn.mokryinos.ru/images/site/catalog/480x480/2_18827_1543579579.webp"),
        Product(
            product_id: 15236,
            product_name: "Farmina N&D Prime Мясо дикого кабана/Яблоко (б/зерн) для кошек",
            product_category: "СУПЕРПРЕМИУМ СУХОЙ КОРМ ДЛЯ КОШЕК",
            product_price: 2748,
            product_main_image: "https://cdn.mokryinos.ru/images/site/catalog/480x480/2_17559_1543579300.webp"),
        Product(
            product_id: 24055,
            product_name: "Monge BWild Cat Grain Free Sterilised Тунец/Горох для кошек",
            product_category: "СУПЕРПРЕМИУМ СУХОЙ КОРМ ДЛЯ КОШЕК",
            product_price: 1977,
            product_main_image: "https://cdn.mokryinos.ru/images/site/catalog/480x480/2_24603_1605866852.webp"),
        Product(
            product_id: 16281,
            product_name: "Grandorf Adult Medium/Maxi PROBIOTICS 4 вида мяса/рис для собак",
            product_category: "СУПЕРПРЕМИУМ СУХОЙ КОРМ ДЛЯ СОБАК",
            product_price: 2798,
            product_main_image: "https://cdn.mokryinos.ru/images/site/catalog/480x480/2_17602_1666936819.webp"),
        Product(
            product_id: 24170,
            product_name: "Grandorf Adult Mini Индейка/рис для собак",
            product_category: "СУПЕРПРЕМИУМ СУХОЙ КОРМ ДЛЯ СОБАК МАЛЕНЬКИХ ПОРОД",
            product_price: 2648,
            product_main_image: "https://cdn.mokryinos.ru/images/site/catalog/480x480/2_24748_1602838367.webp"),
        Product(
            product_id: 4793,
            product_name: "Бравекто табл для собак (цена за 1 шт)",
            product_category: "ПРОТИВ БЛОХ И КЛЕЩЕЙ. КАПЛИ, ТАБЛЕТКИ ДЛЯ СОБАК",
            product_price: 2318,
            product_main_image: "https://cdn.mokryinos.ru/images/site/catalog/480x480/2_18387_1612493556_3.webp"),
        Product(
            product_id: 26196,
            product_name: "Бравекто Плюс капли для кошек",
            product_category: "ПРОТИВ БЛОХ И КЛЕЩЕЙ. КАПЛИ, ТАБЛЕТКИ ДЛЯ КОШЕК",
            product_price: 2598,
            product_main_image: "https://cdn.mokryinos.ru/images/site/catalog/480x480/2_26883_1616642023_2.webp"),
        Product(
            product_id: 12356,
            product_name: "Feliway Классик комплект (флакон+диффузор) для кошек 48 мл",
            product_category: "УСПОКОИТЕЛЬНЫЕ, КОРРЕКЦИЯ ПОВЕДЕНИЯ",
            product_price: 3587,
            product_main_image: "https://cdn.mokryinos.ru/images/site/catalog/480x480/2_1206_1628477668.webp")
    ]

    // MARK: - Constructions

    private init() {}

}
