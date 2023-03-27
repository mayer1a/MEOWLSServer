//
//  MockDetailedProducts.swift
//
//
//  Created by Artem Mayer on 28.03.2023.
//

import Vapor

struct MockDetailedProducts {

    // MARK: - Properties

    static let shared = MockDetailedProducts()

    let products: [Int: DetailedProduct] = [
        23019: DetailedProduct(
            product_description: """
                Сухой корм для кошек с проблемной кожей и шерстью или склонных к аллергии

                Достоинства:
                • профилактика мочекаменной болезни
                • обеспечение отличного состояния кожного покрова и шерсти
                • противодействие возникновению аллергических реакций
                • препятствие старению клеток
                • усиление естественной защиты животного
                • забота об физическом самочувствии

                Состав:
                Дегидрированное мясо трески, Дегидрированное мясо сельди, Цельный бурый рис, Дегидрированное мясо индейки, Свежее мясо индейки, Жир индейки, Антарктический Криль (естественный источник EPA и DHA), Сушеный цикорий, (естественный источник FOS и инулина), Сушеное яблоко, Пивные дрожжи (естественный источник MOS), Сушеная морковь, Сушеный шпинат, Семена льна, Таурин, Сушеная клюква, Юкка Шидигера. Сохранено витамином С, розмарином и смесью природных токоферолов.

                Пищевая ценность %:
                Протеин: 33,0; Жир:16,0; Omega-6: 3,5; Omega-3: 0,8; Зола: 7,5; Клетчатка: 2,5; Влажность: 6,0; Кальций (Са): 1,2; Фосфор (P): 1,0; Магний (Mg): 0,09; pH: 6-6,5

                Витамины (мг/кг):
                Витамин A (МЕ/кг): 20.000; Витамин D3 (МЕ/кг): 1.500; Витамин E (a-токоферол): 600; Витамин В1: 10.0; B2:8.0; B6: 8.0; B12: 180.0; Пантотеновая кислота: 50.0; Холин: 1250.0; Фолиевая кислота: 4,0; Биотин (мкг/кг): 250,0; Никотиновая кислота: 180,0
                """,
            images: [
                "https://cdn.mokryinos.ru/images/site/catalog/480x480/2_17618_1675935990.webp",
                "https://cdn.mokryinos.ru/images/site/catalog/480x480/2_17618_1675935989.webp"
            ]),
        16719: DetailedProduct(
            product_description: """
                Сухой корм для котят в возрасте от 3-х недель, беременных и кормящих кошек.

                Достоинства:
                • укрепление сердечно-сосудистой системы
                • забота о здоровье мочевыводящих путей
                • усиление естественной защиты организма
                • стабилизация работы органов пищеварения
                • уменьшение пищевой аллергической реакции
                • поддержка полезной микрофлоры
                • борьба с развитием патогенных бактерий
                • улучшение метаболизма
                • нормализация и сохранение идеальной массы тела
                • предотвращение образования зубного камня
                • уход за полостью рта
                • оздоровление кожного покрова и шерсти
                • поддержание отличного состояния суставов и развитие мышц
                • улучшение качества зрения

                Состав:
                Дегидрированное мясо ягненка, дегидрированное мясо индейки, цельный белый рис, свежее мясо ягненка, свежее мясо индейки, жир индейки, сушеный цикорий, (естественный источник FOS и инулина), сушеный антарктический криль (естественный источник EPA и DHA), пивные дрожжи (естественный источник MOS), пищевые волокна, таурин, сушеная клюква, юкка шидигера, L-карнитин,комплекс натуральных антиоксидантов (экстракт розмарина, куркумы, цитрусовых и сигизиума).

                Пищевая ценность %:
                Протеин: 34,0; Жир:22,0; Omega-6: 3,7; Omega-3: 0,8; Зола: 7,5; Клетчатка: 2,5; Влажность: 6,0; Кальций (Са): 1,2; Фосфор (P): 1,0; Магний (Mg): 0,09; pH: 6-6,5

                Витамины (мг/кг):
                Витамин A (МЕ/кг): 20.000; Витамин D3 (МЕ/кг): 1.500; Витамин E (a-токоферол): 600; Витамин В1: 20.0; B2:20.0; B6: 12.0; B12: 180.0; Пантотеновая кислота: 50.0; Холин: 2500.0; Фолиевая кислота: 8,5; Биотин (мкг/кг): 250,0; Никотиновая кислота: 180,0
                """,
            images: [
                "https://cdn.mokryinos.ru/images/site/catalog/480x480/2_17622_1606105053.webp"
            ]),
        18320: DetailedProduct(
            product_description: """
                Farmina N&D Ancestral Grain Neutered Курица/Гранат низкозерновой для кастрированных кошек

                Сбалансированное питание по всем правилам холистик-класса: низкий процент или отсутствие зерновых, высокий процент белка животного происхождения, свежее мясо, никаких субпродуктов. Корм имеет в составе лекарственые травы, пробиотики, облегчающие пищеварение, не содержит консервантов.

                Достоинства:
                • Высокое содержание белков животного происхождения (до 70%), источником которых является свежее мясо или свежая рыба,
                • Оптимальный баланс витаминов и минеральных веществ, источником которых служат свежие фрукты и овощи,
                • Содержание лекарственных растений для поддержания здоровья и улучшения качества жизни,
                • Содержание легко усваиваемых жиров животного происхождения,
                • Отсутствие в продуктах зерна, а в качестве источников углеводов - картофель.

                Состав:
                Свежее куриное филе (24%), дегидратированное куриное мясо (24%), спельта (10%), овес (10%), дегидратированные цельные яйца, свежая сельдь, дегидратированная сельдь, гидролизат животного белка, пульпа сахарной свеклы, куриный жир, рыбий жир, волокна гороха, сушеная люцерна, сушеная морковь, инулин, фруктоолигосахариды, маннанолигосахариды, порошок граната (0,5%), сушеные яблоки, порошок шпината, подорожник (0,3%), порошок черной смородины, дегидратированный сладкий апельсин, порошок черники, хлорид натрия , сухие пивные дрожжи, корень куркумы (0,2%), глюкозамин, хондроитинсульфат, экстракт календулы (источник лютеина).

                Пищевая ценность:
                Сырой протеин 38,00%; сырой жир и масла 10,00%; сырая клетчатка 5,50%; сырая зола 8,30%; кальций 1,20%; фосфор 1,00%; магний 0,09%; Омега-6 1,80%; Омега-3 0,40%; DHA 0,25%; EPA 0,15%; глюкозамин 1200мг/кг; хондроитин 900мг/кг.

                Пищевые добавки на 1 кг:
                Витамин А 18000МЕ; Витамин D3 1200МЕ; Витамин Е 600мг; Витамин С 300мг; Ниацин 150мг; Пантотеновая кислота 50мг; Витамин В2 20мг; Витамин В6 8,1мг; Витамин В1 10мг; Витамин H 1,5мг; Фолиевая кислота 1,5мг; Витамин B12 0,1мг; хлорид холина 2800мг; бета-каротин 1,5мг; хелат цинка 910мг; хелат марганца 380мг; хелат железа 250мг; хелат меди 88мг; селенометионин 0,4мг; DL-метионин 5000мг; таурин 5000мг; L-карнитин 400мг.

                Специальные добавки:
                Экстракт алоэ вера 1000мг; экстракт зеленого чая 100мг; Экстракт розмарина. Антиоксиданты: токоферол из экстрактов натурального происхождения.
                """,
            images: [
                "https://cdn.mokryinos.ru/images/site/catalog/480x480/2_18827_1543579579.webp"
            ]),
        15236: DetailedProduct(
            product_description: """
                Farmina N&D Prime Мясо дикого кабана/Яблоко беззерновой для кошек

                Сбалансированное питание по всем правилам холистик-класса: низкий процент или отсутствие зерновых, высокий процент белка животного происхождения, свежее мясо, никаких субпродуктов. Корм имеет в составе лекарственые травы, пробиотики, облегчающие пищеварение, не содержит консервантов.

                Достоинства:
                • Высокое содержание белков животного происхождения (до 70%), источником которых является свежее мясо или свежая рыба,
                • Оптимальный баланс витаминов и минеральных веществ, источником которых служат свежие фрукты и овощи,
                • Содержание лекарственных растений для поддержания здоровья и улучшения качества жизни,
                • Содержание легко усваиваемых жиров животного происхождения,
                • Отсутствие в продуктах зерна, а в качестве источников углеводов - картофель.

                Состав:
                Свежее мясо дикого кабана без костей (25%), дегидратированное мясо кабана (23%), картофель, свежее мясо курицы без костей, дегидратированное мясо курицы, куриный жир, дегидратированные цельные яйца, свежая сельдь, дегидратированная сельдь, гидролизат животного белка, рыбий жир, волокна гороха, сушеная морковь, сушеная люцерна, инулин, фруктоолигосахариды, маннанолигосахариды, дегидратированные яблоки (0,5%), порошок граната, дегидратированный сладкий апельсин, порошок шпината, подорожник (0,3%), порошок черной смородины (0,3%), порошок черники, хлорид натрия, дрожжи сухие пивные, корень куркумы (0,2%), глюкозамин, хондроитин сульфат, экстракт календулы (источник лютеина).

                Пищевая ценность:
                Сырой протеин 44,00%; сырой жир и масла 20,00%; сырая клетчатка 1,80%; сырая зола 8,70%; кальций 1,50%; фосфор 1,30%; магний 0,09%; Омега-6 3,40%; Омега-3 0,90%; DHA 0,50%; EPA 0,30%; глюкозамин 1200мг/кг; хондроитин сульфат 900мг/кг.

                Пищевые добавки на 1 кг:
                Витамин А 18000МЕ; Витамин D3 1200МЕ; Витамин Е 600мг; Витамин С 300мг; Витамин РР 150мг; Пантотеновая кислота 50мг; Витамин В2 20мг; Витамин В6 8,1мг; Витамин В1 10мг; Витамин Н 1,5мг; Фолиевая кислота 1,5мг; Витамин В12 0,1мг; холина хлорид 2500мг; бета-каротин 1,5мг; цинк 910мг; марганец 380мг; железо 250мг; медь 88мг; селенометионин 0,40мг; DL-метионин 5000мг; таурин 4000мг; L-карнитин 300мг.

                Специальные добавки:
                Алоэ вера экстракт 1000мг; экстракт зеленого чая 100мг; Экстракт розмарина. Антиоксиданты: токоферол из экстрактов натурального происхождения.
                """,
            images: [
                "https://cdn.mokryinos.ru/images/site/catalog/480x480/2_17559_1543579300.webp"
            ]),
        24055: DetailedProduct(
            product_description: """
                Сухой корм Monge BWild Cat Grain Free Sterilised Тунец/Горох для кошек

                Достоинства:
                • Омега-3 и омега-6 жирные кислоты позволяют предупредить воспалительные процессы и сохранить здоровье кожи и блеск шерсти питомца.
                • X.O.S. и М.О.S. - пребиотики, которые поддерживают здоровье кишечника.
                • L-карнитин и DL-метионин стимулируют метаболические процессы в организме

                Состав:
                Дегидрированный тунец (38%), картофель (15%), свежее мясо курицы (15%), животный жир (10%) (очищенное куриное масло 99,5%), картофельный белок, сухая свекольная пульпа, горох (5%), волокна гороха, гидролизованный животный белок, дегидрированный лосось (4%), минеральные вещества, рыбий жир (очищенное лососевое масло 99,5%), маннанолигосахариды (M.O.S. 1%), спирулина (0,6%), ксилоолигосахариды (X.O.S. 0,3%), юкка Шидигера (0,1%), порошок молочного белка.

                Пищевая ценность:
                Сырой белок 33%, сырая клетчатка 6%, сырой жир 11%, сырая зола 7,5%, кальций 1,4%, фосфор 1%, магний 0,08%, натрий 0,6%, омега-3 жирные кислоты: 0,5%, омега-6 жирные кислоты: 2,5%.

                Добавки на 1 кг:
                Витамин A (ретинола ацетат): 34 300 МЕ/кг, витамин D3 2 400 МЕ/кг, витамин Е (альфа-токоферола ацетат): 490 мг/кг, селен (селенит натрия 0,44 мг/кг): 0,3 мг/кг, марганец (сульфат марганца моногидрат 95 мг/кг): 32 мг/кг, цинк (оксид цинка 196 мг/кг): 150 мг/кг, медь (сульфат меди (II) пентогидрат 48 мг/кг): 12 мг/кг, железо (сульфат железа (II) моногидрат 340 мг/кг): 108 мг/кг, йод (йодат кальция безводный 2,6 мг/кг): 1,7 мг/кг, DL-метионин технически очищенный 1000 мг/кг, L-карнитин 1 000 мг/кг, таурин 1 200 мг/кг.

                Энергетическая ценность: 3755 ккал/кг.
                """,
            images: [
                "https://cdn.mokryinos.ru/images/site/catalog/480x480/2_24603_1605866852.webp",
                "https://cdn.mokryinos.ru/images/site/catalog/480x480/2_24603_1638873391.webp",
                "https://cdn.mokryinos.ru/images/site/catalog/480x480/2_24603_1638873391_1.webp"
            ]),
        16281: DetailedProduct(
            product_description: """
                Сухой корм Grandorf PROBIOTICS 4 вида мяса для собак средних и крупных пород, низкозерновой с живыми пробиотиками

                Идеально подходит питомцам с чувствительным пищеварением или склонным к аллергии.

                Миллиард живых пробиотиков ежедневно поддерживают микрофлору кишечника, улучшают пищеварение, усвоение питательных веществ и предотвращают аллергию.

                Достоинства:
                • 65% мяса в составе
                • 4 вида диетического мяса
                • Живые пробиотики
                • Низкозерновой состав
                • Гипоаллергенные ингредиенты
                • 25% белки, 15% жиры

                Состав:
                Дегидрированное мясо ягненка (12%), Дегидрированное мясо индейки (12%), Дегидрированное мясо утки (12%), Дегидрированное мясо дикого кабана (12%), Цельнозерновой коричневый рис, Свежее мясо индейки (10%), Жир индейки (5%), Сушеный батат, Свежее масло лосося (1%), Порошок корней цикория (натуральный источник пребиотиков: ФОС и инулин), Сушеный антарктический криль (натуральный источник ЭПК и ДГК кислот, 1%), Сушеное яблоко, Мука из плодов рожкового дерева, Пивные дрожжи (натуральный источник МОС), Глюкозамин (1500 мг/кг), Хондроитин сульфат (1000 мг/кг), MSM (метилсульфонилметан, 40 мг/кг), Сушеная клюква, Юкка Мохаве. Кроме заявленных в составе животных ингредиентов продукт может содержать следы ДНК других ингредиентов животного или растительного происхождения в незначительных количествах из-за технологических особенностей производства кормов.

                Пищевая ценность:
                Сырой протеин: 25%; Сырая клетчатка: 3,5%; Сырой жир: 15%; Сырая зола: 7%; Влажность: 9%; Кальций: 1,6%; Фосфор: 1,2%; Омега 6 жирные кислоты: 2,5%; Омега 3 жирные кислоты: 0,8%

                Витамины:
                Витамин А (3а672а): 20.000 МЕ/кг; Витамин D3 (3а671): 2.000 МЕ/кг; Витамин Е (3а700): 150 мг/кг; Витамин С (3а312): 100 мг/кг;

                Микроэлементы (мг/кг):
                Железо (3b103 - 3b106): 45; Медь (3b405 - 3b406): 13; Цинк (3b605 - 3b606): 50; Марганец (3b503 - 3b504): 40; Йод (3b201): 1,5; Селен (3b801): 0,2;

                Стабилизатор кишечной флоры:
                Enterococcus faecium (CFU/kg): 109

                Аминокислоты:
                Таурин (3a370): 1000 мг/кг

                Антиоксиданты:
                Богатые токоферолом экстракты из растительных масел 1000 мг/кг

                Энергетическая ценность (100 г): 417 ккал
                """,
            images: [
                "https://cdn.mokryinos.ru/images/site/catalog/480x480/2_17602_1666936819.webp",
                "https://cdn.mokryinos.ru/images/site/catalog/480x480/2_17602_1666947968.webp"
            ]),
        24170: DetailedProduct(
            product_description: """
                Сухой корм Grandorf Adult Mini Индейка/рис для собак мелких пород

                Достоинства:
                • 70% мяса в составе
                • Низкозерновой состав
                • Один источник животного белка
                • Гипоаллергенные ингредиенты

                Состав:
                Дегидрированное мясо индейки, Свежее мясо индейки, Цельный бурый рис, Соус из индейки, Жир индейки (консервированный смесью токоферолов), Свежее лососевое масло, Льняное семя, Сушеный цикорий (натуральный источник FOS и инулина), Cушеные пивные дрожжи (натуральный источник MOS), Глюкозамин гидрохлорид (500 мг/кг), Хондроитин сульфат (500 мг/кг), МСМ (Метилсульфонилметан), Cушеное яблоко, Cушеный шпинат, Cушеная брокколи, Cушеная клюква, Cушеная черника, Юкка Шидигера, Смесь растительных экстрактов (Розмарина, Грейпфрута, Апельсина, Куркумы и Сизигиума). Сохранено смешанными токоферолами (источник витамина Е) и розмарином. Произведено без: кукурузы, пшеницы, курицы, куриного жира, яиц, субпродуктов, сои, глютена, ГМО, красителей, искусственных ароматизаторов и консервантов.

                Пищевая ценность:
                Протеин: 27,0%; Жир:13,0%; Omega-6: 2,5%; Omega-3: 0,6%; Зола: 7,5%; Клетчатка: 3,5%; Влажность: 9,0%; Кальций (Са): 1,6%; Фосфор (P): 1,1%

                Энергетическая ценность: 4020 ккал/кг
                """,
            images: [
                "https://cdn.mokryinos.ru/images/site/catalog/480x480/2_24748_1602838367.webp"
            ]),
        4793: DetailedProduct(
            product_description: """
                Антипаразитарные таблетки для собак

                Достоинства:
                • системное уничтожение эктопаразитов и клещей, предотвращение трансмиссивных заболеваний
                • снимает симптомы зуда и раздражения
                • имеет приятный вкус, легко поедается питомцем

                Форма выпуска и состав:
                Действующее вещество - флураланер, в 1 таблетке:
                • 112,5 мг для собак массой 2 — 4,5 кг;
                • 250,0 мг для собак массой 4,5 — 10 кг;
                • 500,0 мг для собак массой >10 — 20 кг;
                • 1000,0 мг для собак массой >20 — 40 кг;
                • 1400,0 мг для собак массой >40 — 56 кг.
                Действие препарата -12 недель

                Способ применения:
                Бравекто применяют собакам индивидуально перорально во время или незадолго до/после кормления в терапевтической дозе 25-56 мг флураланера на 1 кг массы животного. Бравекто обладает привлекательным ароматом и вкусом и, как правило, охотно поедается собаками; в противном случае, препарат вводят принудительно непосредственно в пасть или скармливают с кормом. Разламывание таблеток не допускается. Следует убедиться в том, что собака полностью проглотила необходимую дозу препарата.
                """,
            images: [
                "https://cdn.mokryinos.ru/images/site/catalog/480x480/2_18387_1612493556_3.webp",
                "https://cdn.mokryinos.ru/images/site/catalog/480x480/2_18387_1612493556_2.webp",
                "https://cdn.mokryinos.ru/images/site/catalog/480x480/2_18387_1612493556_1.webp",
                "https://cdn.mokryinos.ru/images/site/catalog/480x480/2_18387_1612493556.webp",
                "https://cdn.mokryinos.ru/images/site/catalog/480x480/2_18387_1612493555.webp"
            ]),
        26196: DetailedProduct(
            product_description: """
                Бравекто Плюс капли для кошек

                Показания:
                Бравекто Плюс применяют кошкам для лечения и профилактики заражения иксодовыми клещами, желудочно-кишечными нематодами, сердечными гельминтами, вызывающими дирофиляриоз, а так же при лечении кошек при отодектозе. Может применяться в комплексной терапии при лечении аллергического дерматита, вызываемого блохами.

                Состав и форма выпуска:
                В 1,0 мл препарата содержится 280 мг флураланера, 14 мг моксидектина и вспомогательные вещества: бутилгидрокситолуол, диметилацетамид, глюкофурол, диэтилтолуамид, ацетон.
                • 1,2 - 2,8 кг: Бравекто Плюс 112,5 мг/5,6 мг (1 пипетка 0,4 мл)
                • 2,8 - 6,25 кг: Бравекто Плюс 250 мг/12,5 мг (1 пипетка 0,89 мл)
                • 6,25 - 12,5 кг: Бравекто Плюс 500 мг/25 мг (1 пипетка 1,79 мл)

                Способ применения:
                В ходе применения препарата кошка должна стоять или лежать так, чтобы ее спина находилась в горизонтальном положении. Наконечник пипетки размещают над головой кошки.
                Аккуратно сдавливают пипетку, нанося все содержимое пипетки непосредственно на кожу кошки. Для кошек весом до 6,25 кг препарат следует наносить в одном месте, в области основания черепа; для кошек весом свыше 6,25 кг – в других местах.
                Для кошек с массой тела более 12,5 кг используют сочетание двух пипеток, которое больше всего соответствует массе тела животного.
                Для оптимального контроля заражения блохами и клещами, а также для профилактики дирофиляриоза данный препарат следует применять с интервалами 12 недель.
                """,
            images: [
                "https://cdn.mokryinos.ru/images/site/catalog/480x480/2_26883_1616642023_2.webp",
                "https://cdn.mokryinos.ru/images/site/catalog/480x480/2_26883_1616642023_2.webp",
                "https://cdn.mokryinos.ru/images/site/catalog/480x480/2_26883_1616642023_1.webp"
            ]),
        12356: DetailedProduct(
            product_description: """
                Feliway-Классик комплект (флакон+диффузор) для кошек

                Состав и форма выпуска:
                В качестве действующего вещества препарат содержит синтетический аналог феромона лицевых желез кошки F3 (Феливей), который стабилизирует эмоциональное состояние кошки, подавляет инстинкт маркировки мочой, помогает кошкам ориентироваться и адаптироваться в новых условиях.
                По внешнему виду препарат представляет собой бесцветную прозрачную жидкость. Продукт не имеет запаха, не токсичен, не влияет на самочувствие людей, не имеет наркотических и транквилизаторных свойств.

                Фармакологические свойства:
                Феливей Классик — наиболее эффективный и безопасный способ восстановить хорошее самочувствие и нормализовать поведение кошки в стрессовой ситуации. Синтетический аналог феромона лицевых желез кошки, который «информирует» кошку об отсутствии причин для беспокойства, стабилизирует ее эмоциональное состояние, уменьшают или полностью прекращают стрессовое поведение: маркировку территории мочой и царапинами, потерю аппетита, чрезмерный груминг (вылизывание), нежелания играть или общаться, помогает кошкам ориентироваться и адаптироваться. Препарат не является лекарственным средством.

                Показания:
                Применяют кошкам: при смене места жительства; перестановке мебели в квартире; при посещении выставки; транспортировке кошки; при раннем отлучении котят от матери; для устранения бродяжничества; во время и после визита к ветврачу; при появлении нового члена семьи; для устранения агрессии, связанной с прикосновениями незнакомых людей; при появлении нечистоплотности; при групповом содержании кошек.

                Способ применения:
                Феливей для кошек прост в применении: диффузор включается в электрическую розетку, действующее вещество испаряется и циркулирует в воздухе, нормализуя эмоциональное состояние кошки. Площадь действия 50-70 квадратных метров. Срок действия одного флакона: 4 недели.

                • Снимите крышку с флакона.
                • Вставьте флакон в диффузор и закрутить до ощущения легкого сопротивления.
                • Собранный диффузор включите в электрическую розетку.
                • Не используйте электрические розетки, расположенные в труднодоступных местах (за дверью, за занавеской, за шкафом или под столом).
                • Диффузор должен оставаться постоянно включённым в течение 4 недель.
                • Заменяйте флакон по мере необходимости. При появлении признаков стресса у кошки рекомендуется обратиться к ветеринарному доктору для исключения возможных заболеваний, которые потребуют дальнейшего лечения.

                Особые указания:
                Электрический диффузор разработан специально для продукта «Feliway-феромон для кошек». Использование другого электрического устройства не гарантирует свойства продукта.

                Не использовать Feliway флакон без диффузора.
                """,
            images: [
                "https://cdn.mokryinos.ru/images/site/catalog/480x480/2_1206_1628477668.webp"
            ])
    ]

    // MARK: - Constructions

    private init() {}
}
