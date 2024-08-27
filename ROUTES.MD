# Содержание

- [Города](#города)
- [Корзина](#корзина)
- [Категории](#категории)
- [Избранное](#избранное)
- [Главная / Баннеры](#главная--баннеры)
- [Товары](#товары)
- [Акции](#акции)
- [Поиск](#поиск)
- [Подсказки. Адреса](#подсказки-адреса)
- [Подсказки. ФИО](#подсказки-фио)
- [Пользователь](#пользователь)
- [Заказы чекаут](#заказы-чекаут)
- [Заказы пользователя](#заказы-пользователя)
- [Системное](#системное)

## Города

### Список доступных городов `GET api/v1/cities`

**Request**

```zsh
curl --location 'localhost:8080/api/v1/cities'
```
  
**Response**

```json
[
  {
    "name": "Новосибирск",
    "id": "8DEA00E3-9AAB-4D8E-887C-EF2AAA546456"
  },
  {
    "id": "140E31DA-27BF-4519-9EA0-6185D681D44E",
    "name": "Омск"
  },
  ...,
  {
    "name": "Самара",
    "id": "BB035CC3-1DC2-4627-9D25-A1BF2D4B936B"
  }
]
```

---

## Корзина

### Обновление корзины `POST api/v1/cart/update`

**Request**

```zsh
curl --location 'localhost:8080/api/v1/cart/update' \
--header 'Content-Type: application/json' \
--header 'Authorization: Token Ld0J7jrtrJMnsL2dVMTINP2n/9e7Ps472125NTESOeg=' \
--data '{
  "cart": {
    "items": [
      {
        "article": "39046",
        "count": 1
      },
      {
        "article": "39052",
        "count": 1
      }
    ],
    "save": true
  }
}'
```
  
**Response**

```json
{
  "id": "70DC6034-5567-4830-A3EC-D1B07A14582C",
  "summaries": [
    {
      "value": 10196,
      "type": "ITEMS_WITHOUT_DISCOUNT",
      "name": "Товары без скидки"
    },
    {
      "value": 10196,
      "name": "Итого:",
      "type": "TOTAL"
    }
  ],
  "items": [
    {
      "id": "F997B623-4459-4838-B4DC-9360DDD51D4E",
      "count": 1,
      "image": {
        "original": "https://static.artemayer.ru/images/site/catalog/2_64706e30d5d78.jpeg",
        "medium": "https://static.artemayer.ru/images/site/catalog/480x480/2_64706e30d5d78.jpeg",
        "small": "https://static.artemayer.ru/images/site/catalog/192x200/2_64706e30d5d78.jpeg",
        "large": "https://static.artemayer.ru/images/site/catalog/700x700/2_64706e30d5d78.jpeg"
      },
      "variant_name": "5 кг",
      "article": "39046",
      "price": {
        "original_price": 3998,
        "price": 3998
      },
      "availability_info": {
        "type": "available",
        "count": 3
      },
      "product_name": "Wonderfur Sterilised Курица/индейка для кошек",
      "product_id": "9681E266-5D23-446A-B18A-47303BEAF04E",
      "badges": [
        {
          "title": "Новинка",
          "background_color": "#66CC00",
          "tint_color": "#FFFFFF"
        }
      ],
      "amount": {
        "original_price": 3998,
        "price": 3998
      }
    },
    {
      "product_id": "278986E6-7568-4362-A9CE-9C04A485F612",
      "price": {
        "price": 6198,
        "original_price": 6198
      },
      "variant_name": "10 кг",
      "count": 1,
      "badges": [],
      "image": {
        "medium": "https://static.artemayer.ru/images/site/catalog/480x480/2_650bc783a9c07.jpeg",
        "original": "https://static.artemayer.ru/images/site/catalog/2_650bc783a9c07.jpeg",
        "large": "https://static.artemayer.ru/images/site/catalog/700x700/2_650bc783a9c07.jpeg",
        "small": "https://static.artemayer.ru/images/site/catalog/192x200/2_650bc783a9c07.jpeg"
      },
      "amount": {
        "original_price": 6198,
        "price": 6198
      },
      "id": "C03123D3-0C39-48E0-9BD6-B1A4064C6151",
      "product_name": "Wonderfur Adult All breeds Говядина/Рис для собак",
      "availability_info": {
        "count": 3,
        "type": "available"
      },
      "article": "39052"
    }
  ]
}
```

---

### Корзина пользователя `GET api/v1/cart/update`

**Request**

```zsh
curl --location 'localhost:8080/api/v1/cart' \
--header 'Authorization: Token Ld0J7jrtrJMnsL2dVMTINP2n/9e7Ps472125NTESOeg='
```
  
**Response**

```json
{
  "id": "70DC6034-5567-4830-A3EC-D1B07A14582C",
  "summaries": [
    {
      "value": 10196,
      "type": "ITEMS_WITHOUT_DISCOUNT",
      "name": "Товары без скидки"
    },
    {
      "value": 10196,
      "name": "Итого:",
      "type": "TOTAL"
    }
  ],
  "items": [
    {
      "id": "F997B623-4459-4838-B4DC-9360DDD51D4E",
      "count": 1,
      "image": {
        "original": "https://static.artemayer.ru/images/site/catalog/2_64706e30d5d78.jpeg",
        "medium": "https://static.artemayer.ru/images/site/catalog/480x480/2_64706e30d5d78.jpeg",
        "small": "https://static.artemayer.ru/images/site/catalog/192x200/2_64706e30d5d78.jpeg",
        "large": "https://static.artemayer.ru/images/site/catalog/700x700/2_64706e30d5d78.jpeg"
      },
      "variant_name": "5 кг",
      "article": "39046",
      "price": {
        "original_price": 3998,
        "price": 3998
      },
      "availability_info": {
        "type": "available",
        "count": 3
      },
      "product_name": "Wonderfur Sterilised Курица/индейка для кошек",
      "product_id": "9681E266-5D23-446A-B18A-47303BEAF04E",
      "badges": [
        {
          "title": "Новинка",
          "background_color": "#66CC00",
          "tint_color": "#FFFFFF"
        }
      ],
      "amount": {
        "original_price": 3998,
        "price": 3998
      }
    },
    {
      "product_id": "278986E6-7568-4362-A9CE-9C04A485F612",
      "price": {
        "price": 6198,
        "original_price": 6198
      },
      "variant_name": "10 кг",
      "count": 1,
      "badges": [],
      "image": {
        "medium": "https://static.artemayer.ru/images/site/catalog/480x480/2_650bc783a9c07.jpeg",
        "original": "https://static.artemayer.ru/images/site/catalog/2_650bc783a9c07.jpeg",
        "large": "https://static.artemayer.ru/images/site/catalog/700x700/2_650bc783a9c07.jpeg",
        "small": "https://static.artemayer.ru/images/site/catalog/192x200/2_650bc783a9c07.jpeg"
      },
      "amount": {
        "original_price": 6198,
        "price": 6198
      },
      "id": "C03123D3-0C39-48E0-9BD6-B1A4064C6151",
      "product_name": "Wonderfur Adult All breeds Говядина/Рис для собак",
      "availability_info": {
        "count": 3,
        "type": "available"
      },
      "article": "39052"
    }
  ]
}
```

---

### Корзина анонимного пользователя `POST api/v1/cart`

**Request**

```zsh
curl --location 'localhost:8080/api/v1/cart' \
--header 'Content-Type: application/json' \
--data '{
  "cart": {
    "items": [
      {
        "article": "39046",
        "count": 1
      },
      {
        "article": "39052",
        "count": 1
      }
    ],
    "save": false
  }
}'
```
  
**Response**

```json
{
  "id": "7B2511A3-9D1A-4A96-831A-F716B3A7C6C5",
  "summaries": [
    {
      "value": 10196,
      "name": "Товары без скидки",
      "type": "ITEMS_WITHOUT_DISCOUNT"
    },
    {
      "value": 10196,
      "type": "TOTAL",
      "name": "Итого:"
    }
  ],
  "items": [
    {
      "product_id": "9681E266-5D23-446A-B18A-47303BEAF04E",
      "product_name": "Wonderfur Sterilised Курица/индейка для кошек",
      "availability_info": {
        "type": "available",
        "count": 3
      },
      "price": {
        "price": 3998,
        "original_price": 3998
      },
      "image": {
        "large": "https://static.artemayer.ru/images/site/catalog/700x700/2_64706e30d5d78.jpeg",
        "medium": "https://static.artemayer.ru/images/site/catalog/480x480/2_64706e30d5d78.jpeg",
        "small": "https://static.artemayer.ru/images/site/catalog/192x200/2_64706e30d5d78.jpeg",
        "original": "https://static.artemayer.ru/images/site/catalog/2_64706e30d5d78.jpeg"
      },
      "variant_name": "5 кг",
      "amount": {
        "price": 3998,
        "original_price": 3998
      },
      "count": 1,
      "article": "39046",
      "badges": [
        {
          "tint_color": "#FFFFFF",
          "background_color": "#66CC00",
          "title": "Новинка"
        }
      ],
      "id": "30C338D0-CEE4-4FD2-A7A1-2DC189F2240C"
    },
    {
      "id": "409FB64B-15E8-4677-9636-C07901BB47B9",
      "image": {
        "small": "https://static.artemayer.ru/images/site/catalog/192x200/2_650bc783a9c07.jpeg",
        "original": "https://static.artemayer.ru/images/site/catalog/2_650bc783a9c07.jpeg",
        "large": "https://static.artemayer.ru/images/site/catalog/700x700/2_650bc783a9c07.jpeg",
        "medium": "https://static.artemayer.ru/images/site/catalog/480x480/2_650bc783a9c07.jpeg"
      },
      "amount": {
        "original_price": 6198,
        "price": 6198
      },
      "product_id": "278986E6-7568-4362-A9CE-9C04A485F612",
      "count": 1,
      "price": {
        "price": 6198,
        "original_price": 6198
      },
      "variant_name": "10 кг",
      "badges": [],
      "article": "39052",
      "product_name": "Wonderfur Adult All breeds Говядина/Рис для собак",
      "availability_info": {
        "type": "available",
        "count": 3
      }
    }
  ]
}
```

---

## Категории

### Подкатегории, переданной в параметре запроса, категории `GET api/v1/categories?category_id=[CATEGORY_ID]`

`[CATEGORY_ID]` - может быть `null` для получения всех основных категорий

**Request**

```zsh
curl --location 'localhost:8080/api/v1/categories?category_id=E4960D2C-CA4C-466A-926E-F77CDA1059E9'
```
  
**Response**

```json
[
  {
    "has_children": false,
    "code": "wonderfur",
    "name": "Wonderfur",
    "parent": {
      "id": "E4960D2C-CA4C-466A-926E-F77CDA1059E9",
      "has_children": true,
      "code": "korma_sukhie",
      "name": "Корма Сухие"
    },
    "id": "AB4D0103-3C7C-4C92-84CE-DD800BF41066"
  },
  ...,
  {
    "has_children": false,
    "parent": {
      "code": "korma_sukhie",
      "name": "Корма Сухие",
      "id": "E4960D2C-CA4C-466A-926E-F77CDA1059E9",
      "has_children": true
    },
    "id": "77B0C840-ED7B-48DC-B965-A3A1283FC8E0",
    "code": "territoriya",
    "name": "ТерриториЯ"
  }
]
```

---

## Избранное

### Избранные товары пользователя `GET api/v1/favorites`

**Request**

```zsh
curl --location 'localhost:8080/api/v1/favorites' \
--header 'Authorization: Token Ld0J7jrtrJMnsL2dVMTINP2n/9e7Ps472125NTESOeg='
```
  
**Response**

```json
{
  "id": "82D6FA5A-EE1A-4E21-97A7-71B7C83AEDE8",
  "products": [
    {
      "images": [
        {
          "original": "https://static.artemayer.ru/images/site/catalog/2_18553_1634109061_2.jpeg",
          "large": "https://static.artemayer.ru/images/site/catalog/700x700/2_18553_1634109061_2.jpeg",
          "small": "https://static.artemayer.ru/images/site/catalog/192x200/2_18553_1634109061_2.jpeg",
          "medium": "https://static.artemayer.ru/images/site/catalog/480x480/2_18553_1634109061_2.jpeg"
        }
      ],
      "allow_quick_buy": false,
      "id": "9B0CF4D4-DBE7-4D65-B458-35B44834A0FF",
      "name": "TitBit Легкое Говяжье мягкая упаковка для собак",
      "variants": [
        {
          "badges": [
            {
              "text": "Скидка 20% на лакомства Titbit для кошек и собак",
              "background_color": "#B41D92",
              "title": "%",
              "tint_color": "#FFFFFF"
            }
          ],
          "article": "16759",
          "availability_info": {
            "count": 4,
            "type": "available"
          },
          "price": {
            "discount": 20,
            "original_price": 183,
            "price": 146
          },
          "short_name": "21 гр",
          "id": "3624183E-BB13-4C40-B6EA-51846356768D"
        },
        ...,
        {
          "article": "10559",
          "badges": [
            {
              "title": "%",
              "background_color": "#B41D92",
              "text": "Скидка 20% на лакомства Titbit для кошек и собак",
              "tint_color": "#FFFFFF"
            }
          ],
          "price": {
            "price": 646,
            "discount": 20,
            "original_price": 808
          },
          "short_name": "Big 140 гр",
          "id": "98527B97-34ED-468F-A454-DD5F2DB350F2",
          "availability_info": {
            "type": "available",
            "count": 4
          }
        }
      ],
      "default_variant_article": "16759",
      "code": "titbit_legkoe_govyazhe_myagkaya_upakovka_d_sob"
    },
    {
      "default_variant_article": "21038",
      "variants": [
        {
          "short_name": "",
          "id": "1FBD7A61-C7DE-409B-A7BC-DC73EA275DD0",
          "badges": [],
          "availability_info": {
            "type": "available",
            "count": 40
          },
          "article": "21038",
          "price": {
            "price": 25,
            "original_price": 25
          }
        }
      ],
      "images": [
        {
          "large": "https://static.artemayer.ru/images/site/catalog/700x700/2_21479_1627278892.jpeg",
          "small": "https://static.artemayer.ru/images/site/catalog/192x200/2_21479_1627278892.jpeg",
          "original": "https://static.artemayer.ru/images/site/catalog/2_21479_1627278892.jpeg",
          "medium": "https://static.artemayer.ru/images/site/catalog/480x480/2_21479_1627278892.jpeg"
        }
      ],
      "allow_quick_buy": true,
      "id": "88369E6D-FC8F-40E2-91B9-73F91C81AEAC",
      "code": "felix_sup_govyadina_pauch_d_kosh_48_g",
      "name": "Felix Суп Говядина пауч для кошек 48 г"
    },
    ...,
    {
      "name": "Wonderfur Sterilised Индейка/Телятина для кошек",
      "images": [
        {
          "original": "https://static.artemayer.ru/images/site/catalog/2_6507cead7d93f.jpeg",
          "medium": "https://static.artemayer.ru/images/site/catalog/480x480/2_6507cead7d93f.jpeg",
          "large": "https://static.artemayer.ru/images/site/catalog/700x700/2_6507cead7d93f.jpeg",
          "small": "https://static.artemayer.ru/images/site/catalog/192x200/2_6507cead7d93f.jpeg"
        }
      ],
      "allow_quick_buy": false,
      "default_variant_article": "42002",
      "variants": [
        {
          "availability_info": {
            "type": "available",
            "count": 15
          },
          "article": "42002",
          "price": {
            "original_price": 458,
            "price": 458
          },
          "id": "2A00E04B-C0F5-4364-B628-655C8B1E8B96",
          "badges": [],
          "short_name": "400 г"
        },
        ...,
        {
          "price": {
            "original_price": 3998,
            "price": 3998
          },
          "badges": [],
          "short_name": "5 кг",
          "id": "04841956-9956-40B4-BB72-30862D322957",
          "availability_info": {
            "count": 3,
            "type": "available"
          },
          "article": "39050"
        }
      ],
      "code": "wonderfur_sterilised_indeyka_telyatina_dlya_koshek",
      "id": "4FB41070-155F-416A-8996-325AB9B48506"
    }
  ]
}
```

---

### Добавить товар в избранное `POST api/v1/favorites/star`

**Request**

```zsh
curl --location 'localhost:8080/api/v1/favorites/star' \
--header 'Content-Type: application/json' \
--header 'Authorization: Token Ld0J7jrtrJMnsL2dVMTINP2n/9e7Ps472125NTESOeg=' \
--data '[
    "4fb41070-155f-416a-8996-325ab9b48506",
    "d5bcb2da-0a3b-4dbc-b7f1-750c97dbcc06",
    "88369e6d-fc8f-40e2-91b9-73f91c81aeac",
    "9b0cf4d4-dbe7-4d65-b458-35b44834a0ff"
]'
```
  
**Response**

```json
{}
```

---

### Удалить товар из избранного `POST api/v1/favorites/unstar`

**Request**

```zsh
curl --location 'localhost:8080/api/v1/favorites/unstar' \
--header 'Content-Type: application/json' \
--header 'Authorization: Token Ld0J7jrtrJMnsL2dVMTINP2n/9e7Ps472125NTESOeg=' \
--data '[
    "31c0d1fb-82b7-4bd2-88e5-ce3c076765d8"
]'
```
  
**Response**

```json
{}
```

---

## Главная / Баннеры

### Главная страница / Баннеры `GET api/v1/main_page`

**Request**
  
```zsh
curl --location 'localhost:8080/api/v1/main_page'
```

**Response**
```json
[
  {
    "ui_settings": {
      "cornerRadiuses": {
        "top_right": 16,
        "bottom_left": 0,
        "top_left": 16,
        "bottom_right": 0
      },
      "backgroundColor": "#ffffff",
      "autoSlidingTimeout": 5000,
      "spasings": {
        "bottom": 0,
        "top": 0
      }
    },
    "banners": [
      {
        "image": {
          "original": "https://static.artemayer.ru/images/site/index-banners/2_6687ab2d0d80a.jpeg"
        },
        "id": "6C2DAC09-D675-4907-97BB-37F884DE2941",
        "redirect": {
          "object_type": "Sale",
          "products_set": {
            "query": "корма из азии",
            "name": "Результаты поиска по запросу корма из азии"
          },
          "type": "products_collection"
        }
      },
      ...,
      {
        "redirect": {
          "object_type": "Sale",
          "type": "object",
          "object_id": "7C02CD7E-E7B8-4464-BDB3-F1ADACA82FDE"
        },
        "image": {
          "original": "https://static.artemayer.ru/images/site/index-banners/2_65bb632fe408c.jpeg"
        },
        "id": "0CA0C65D-F452-4639-80CC-0380D6697622"
      }
    ],
    "id": "694D48AB-2B18-4B96-B110-39324083E595",
    "place_type": "banners_horizontal"
  },
  ...,
  {
    "banners": [
      {
        "redirect": {
          "type": "products_collection",
          "object_type": "Sale",
          "products_set": {
            "name": "Лежанки, Домики, Когтеточки",
            "category": {
              "id": "B2133A7C-C9C7-4EF6-9094-8C48180C248F",
              "has_children": true,
              "name": "Лежанки, Домики, Когтеточки",
              "code": "lezhanki_domiki_kogtetochki"
            }
          }
        },
        "image": {
          "original": "https://static.artemayer.ru/images/site/compilation-banners/2_6450c5873a6cd.jpeg"
        },
        "id": "94F4DBDB-6BA4-4103-994C-96D7D61E2C36"
      },
      ...,
      {
        "id": "0CBE70EB-071A-492C-87CB-86E686866256",
        "image": {
          "original": "https://static.artemayer.ru/images/site/compilation-banners/2_6450c56ae55d8.jpeg"
        },
        "redirect": {
          "type": "products_collection",
          "object_type": "Sale",
          "products_set": {
            "name": "Корма",
            "category": {
              "name": "Корма",
              "has_children": true,
              "code": "korma",
              "id": "17C23791-1409-4AD0-8C68-D50C551148E4"
            }
          }
        }
      }
    ],
    "title": "Мы рекомендуем",
    "id": "18DE2CC4-386D-46D2-B3B2-7A75DCC4119D",
    "ui_settings": {
      "cornerRadiuses": {
        "bottom_right": 16,
        "bottom_left": 16,
        "top_right": 16,
        "top_left": 16
      },
      "backgroundColor": "#ffffff",
      "spasings": {
        "bottom": 12,
        "top": 0
      },
      "metrics": [
        {
          "width": 1
        },
        ...,
        {
          "width": 0.3
        }
      ]
    },
    "place_type": "banners_vertical"
  }
]
```

---

## Товары

### Товары для указанной категории `GET api/v1/products?category_id={CATEGORY_ID}&page={PAGE_NUMBER}&per_page=20`

**Request**
  
```zsh
curl --location 'localhost:8080/api/v1/products?category_id=CC924CC5-9A10-4EC4-92DB-01B987D02B3C&page=1&per_page=20'
```

**Response**
```json
{
  "results": [
    {
      "images": [
        {
          "original": "https://static.artemayer.ru/images/site/catalog/2_25787_1630556677.jpeg",
          "medium": "https://static.artemayer.ru/images/site/catalog/480x480/2_25787_1630556677.jpeg",
          "large": "https://static.artemayer.ru/images/site/catalog/700x700/2_25787_1630556677.jpeg",
          "small": "https://static.artemayer.ru/images/site/catalog/192x200/2_25787_1630556677.jpeg"
        }
      ],
      "variants": [
        {
          "availability_info": {
            "type": "available",
            "count": 29
          },
          "badges": [
            {
              "background_color": "#B41D92",
              "title": "%",
              "text": "Скидка 31% на влажный корм Felix для кошек",
              "tint_color": "#FFFFFF"
            }
          ],
          "price": {
            "discount": 31,
            "original_price": 39,
            "price": 26.91
          },
          "article": "25178",
          "short_name": "",
          "id": "DCD64987-39D6-468D-AE26-C37EEFF894DC"
        }
      ],
      "default_variant_article": "25178",
      "id": "D7D1492D-850F-4B72-B60C-9CB9B3B9D68D",
      "name": "Felix Sensation Говядина/Сыр пауч для кошек 75 г",
      "code": "felix_sensation_govyadina_syr_pauch_dlya_koshek_85_g",
      "allow_quick_buy": true
    },
    ...,
    {
      "variants": [
        {
          "badges": [
            {
              "background_color": "#B41D92",
              "tint_color": "#FFFFFF",
              "title": "%",
              "text": "Скидка 31% на влажный корм Felix для кошек"
            }
          ],
          "price": {
            "original_price": 39,
            "discount": 31,
            "price": 26.91
          },
          "short_name": "",
          "id": "1BCA7573-358B-4B6C-A4CC-F14A697D3834",
          "article": "15279",
          "availability_info": {
            "count": 32,
            "type": "available"
          }
        }
      ],
      "allow_quick_buy": true,
      "code": "felix_dvoynaya_vkusnyatina_indeyka_pechen_v_zhele_pauch_d_kosh_85_g",
      "images": [
        {
          "medium": "https://static.artemayer.ru/images/site/catalog/480x480/2_657a91f4a3b8a.jpeg",
          "original": "https://static.artemayer.ru/images/site/catalog/2_657a91f4a3b8a.jpeg",
          "large": "https://static.artemayer.ru/images/site/catalog/700x700/2_657a91f4a3b8a.jpeg",
          "small": "https://static.artemayer.ru/images/site/catalog/192x200/2_657a91f4a3b8a.jpeg"
        }
      ],
      "name": "Felix Двойная Вкуснятина Индейка/Печень в желе пауч для кошек 75 г",
      "id": "82866FE3-E6C6-4409-B273-2960F8288A05",
      "default_variant_article": "15279"
    }
  ],
  "paginationInfo": {
    "per_page": 20,
    "next_page": 2,
    "page": 1,
    "total_count": 32
  }
}
```

---

### Товары для указанной акции `GET api/v1/products?sale_id={SALE_ID}&page={PAGE_NUMBER}&per_page=20`

**Request**
  
```zsh
curl --location 'localhost:8080/api/v1/products?sale_id=4c36584a-a423-420d-9804-8737c859d1b4&page=1&per_page=20'
```

**Response**
```json
{
  "results": [
    {
      "name": "Ошейник Hunter Convenience Comfort 55 (42-50 см)/2,5 см биотановый для собак",
      "images": [
        {
          "small": "https://static.artemayer.ru/images/site/catalog/192x200/2_22139_1631771270_4.jpeg",
          "large": "https://static.artemayer.ru/images/site/catalog/700x700/2_22139_1631771270_4.jpeg",
          "medium": "https://static.artemayer.ru/images/site/catalog/480x480/2_22139_1631771270_4.jpeg",
          "original": "https://static.artemayer.ru/images/site/catalog/2_22139_1631771270_4.jpeg"
        }
      ],
      "default_variant_article": "21621",
      "variants": [
        {
          "article": "21621",
          "availability_info": {
            "count": 1,
            "type": "available"
          },
          "short_name": "розовый",
          "id": "82B59B64-C859-4929-99E6-7CFDC01A9CAB",
          "badges": [
            {
              "background_color": "#B41D92",
              "title": "%",
              "tint_color": "#FFFFFF",
              "text": "Скидка 20% на амуницию для собак"
            }
          ],
          "price": {
            "discount": 20,
            "original_price": 2276,
            "price": 1820
          }
        }
      ],
      "allow_quick_buy": true,
      "code": "osheynik_hunter_convenience_comfort_55_42_50_sm_2_5_sm_biotanovyy_d_sob",
      "id": "06C0F947-5AAE-4900-89E4-BB37A68B3DEF"
    },
    ...,
    {
      "images": [
        {
          "original": "https://static.artemayer.ru/images/site/catalog/2_642bf0d0c8df8.jpeg",
          "small": "https://static.artemayer.ru/images/site/catalog/192x200/2_642bf0d0c8df8.jpeg",
          "large": "https://static.artemayer.ru/images/site/catalog/700x700/2_642bf0d0c8df8.jpeg",
          "medium": "https://static.artemayer.ru/images/site/catalog/480x480/2_642bf0d0c8df8.jpeg"
        }
      ],
      "name": "Карабин Вертлюг №2 средний разборный",
      "variants": [
        {
          "article": "16053",
          "badges": [
            {
              "text": "Скидка 20% на амуницию для собак",
              "title": "%",
              "background_color": "#B41D92",
              "tint_color": "#FFFFFF"
            }
          ],
          "short_name": "",
          "id": "DBD3909D-9296-436B-B828-B0C04234FD5E",
          "price": {
            "discount": 20,
            "price": 107,
            "original_price": 134
          },
          "availability_info": {
            "count": 7,
            "type": "available"
          }
        }
      ],
      "allow_quick_buy": true,
      "default_variant_article": "16053",
      "id": "25ABA96F-C3B6-461C-AD6D-7C7C646F9EAD",
      "code": "vertlyug_2_sredniy_otech_razborn"
    }
  ],
  "paginationInfo": {
    "next_page": 2,
    "page": 1,
    "total_count": 34,
    "per_page": 20
  }
}
```

---

### Конкретный товар `GET api/v1/products/{PRODUCT_ID}`

**Request**

```zsh
curl --location 'localhost:8080/api/v1/products/D7D1492D-850F-4B72-B60C-9CB9B3B9D68D'
```

**Response**

```json
{
  "default_variant_article": "25178",
  "delivery_conditions_url": "https://static.artemayer.ru/delivery",
  "sections": [
    {
      "title": "Состав",
      "text": "<p>мясо и мясные ингредиенты (включая говядину), экстракты растительного белка, рыба и продукты ее переработки, ароматизаторы, загустители, минеральные вещества, овощи, сахара, молоко и продукты его переработки (сыр), витамины.</p>\r\n\r\n<h4>Пищевая ценность:</h4>\r\n\r\n<p>влажность: 82%, белок: 11.5%, содержание жира: 2.5%, сырая зола: 2.5%, сырая клетчатка: 0.05%, омега-6 жирные кислоты: 0.4%</p>\r\n\r\n<p>Энергетическая ценность (100 г): 75 ккал</p>\r\n\r\n<h4>Добавки:</h4>\r\n\r\n<p>МЕ/кг: витамин А: 655; витамин Д3: 100; витамин E: 15;<br />\r\nмг/кг: железо: 7.6; йод: 0.19; медь: 0.66; марганец: 1.5; цинк: 13; таурин: 413.</p>\r\n",
      "type": "text_expandable"
    },
    ...,
    {
      "text": "<p>Для взрослой кошки среднего веса (4 кг) требуется 4-5 пакетиков в день; для взрослой стерилизованной кошки требуется 3-4 пакетиков в день. Кормление желательно разделить минимум на два приема.</p>\r\n",
      "type": "text_modal",
      "title": "Рекомендации по питанию"
    }
  ],
  "name": "Felix Sensation Говядина/Сыр пауч для кошек 75 г",
  "allow_quick_buy": true,
  "properties": [
    {
      "selectable": false,
      "name": "Возраст",
      "id": "C0512F7D-B40F-4059-AC38-3F49E392DD2B",
      "code": "age"
    },
    ...,
    {
      "selectable": false,
      "name": "Вес",
      "id": "56396833-D904-4915-931D-132993A3E370",
      "code": "weight"
    }
  ],
  "images": [
    {
      "large": "https://static.artemayer.ru/images/site/catalog/700x700/2_25787_1630556677.jpeg",
      "small": "https://static.artemayer.ru/images/site/catalog/192x200/2_25787_1630556677.jpeg",
      "medium": "https://static.artemayer.ru/images/site/catalog/480x480/2_25787_1630556677.jpeg",
      "original": "https://static.artemayer.ru/images/site/catalog/2_25787_1630556677.jpeg"
    },
    ...,
    {
      "large": "https://static.artemayer.ru/images/site/catalog/700x700/2_25787_1676884429_1.jpeg",
      "small": "https://static.artemayer.ru/images/site/catalog/192x200/2_21479_1676881604_1.jpeg",
      "medium": "https://static.artemayer.ru/images/site/catalog/480x480/2_21479_1676881604_1.jpeg",
      "original": "https://static.artemayer.ru/images/site/catalog/2_21479_1676881604_1.jpeg"
    }
  ],
  "id": "D7D1492D-850F-4B72-B60C-9CB9B3B9D68D",
  "variants": [
    {
      "property_values": [
        {
          "id": "69F9CFBB-58EC-4F51-8CD6-A541F8F81EB7",
          "value": "взрослые (1-6)",
          "property_id": "C0512F7D-B40F-4059-AC38-3F49E392DD2B"
        },
        ...,
        {
          "property_id": "56396833-D904-4915-931D-132993A3E370",
          "value": "75 г",
          "id": "C09ABFF3-E0DE-4E45-B76F-B784EB843DCD"
        }
      ],
      "badges": [
        {
          "tint_color": "#FFFFFF",
          "text": "Скидка 31% на влажный корм Felix для кошек",
          "background_color": "#B41D92",
          "title": "%"
        }
      ],
      "price": {
        "discount": 31,
        "price": 26.91,
        "original_price": 39
      },
      "availability_info": {
        "type": "available",
        "count": 29
      },
      "article": "25178",
      "id": "DCD64987-39D6-468D-AE26-C37EEFF894DC",
      "short_name": ""
    }
  ],
  "code": "felix_sensation_govyadina_syr_pauch_dlya_koshek_85_g"
}
```

---

## Акции

### Список акций `GET api/v1/sales?sale_type={online|offline}&page=1&per_page=20`

**Request**

```zsh
curl --location 'localhost:8080/api/v1/sales?sale_type=online&page=1&per_page=20'
```

**Response**

```json
{
  "results": [
    {
      "id": "6BEAEAEB-5788-4A97-87D8-7E75D7E70E83",
      "start_date": "2023-04-03T00:00:00Z",
      "image": {
        "original": "https://static.artemayer.ru/images/marketing-campaign/6422b56e171ff.jpeg"
      },
      "sale_type": "online",
      "title": "Скидка 31% на влажный корм Felix для кошек",
      "end_date": "2024-12-31T00:00:00Z",
      "code": "skidka-31-na-vlazhnyi-korm-felix-dlia-koshek",
      "disclaimer": "*Количество акционного товара ограничено."
    },
    ...,
    {
      "id": "534A46C8-2A44-4C33-907B-7065A6B47E4E",
      "start_date": "2024-07-01T00:00:00Z",
      "code": "skidka-20-na-lakomstva-titbit-dlia-koshek-i-sobak",
      "image": {
        "original": "https://static.artemayer.ru/images/marketing-campaign/667e7ce3b4e5a.jpg"
      },
      "title": "Скидка 20% на лакомства Titbit для кошек и собак",
      "disclaimer": "*Количество акционного товара ограничено.",
      "sale_type": "online",
      "end_date": "2024-10-31T00:00:00Z"
    }
  ],
  "paginationInfo": {
    "per_page": 20,
    "page": 1,
    "total_count": 12
  }
}
```

---

### Конкретная акция `GET api/v1/sales/{SALE_ID}`

**Request**

```zsh
curl --location 'localhost:8080/api/v1/sales/6BEAEAEB-5788-4A97-87D8-7E75D7E70E83'
```

**Response**

```json
{
  "start_date": "2023-04-03T00:00:00Z",
  "image": {
    "original": "https://static.artemayer.ru/images/marketing-campaign/6422b56e171ff.jpeg"
  },
  "products": [
    {
      "allow_quick_buy": true,
      "code": "felix_sensation_govyadina_syr_pauch_dlya_koshek_85_g",
      "name": "Felix Sensation Говядина/Сыр пауч для кошек 75 г",
      "images": [
        {
          "large": "https://static.artemayer.ru/images/site/catalog/700x700/2_25787_1630556677.jpeg",
          "small": "https://static.artemayer.ru/images/site/catalog/192x200/2_25787_1630556677.jpeg",
          "medium": "https://static.artemayer.ru/images/site/catalog/480x480/2_25787_1630556677.jpeg",
          "original": "https://static.artemayer.ru/images/site/catalog/2_25787_1630556677.jpeg"
        }
      ],
      "variants": [
        {
          "badges": [
            {
              "title": "%",
              "tint_color": "#FFFFFF",
              "background_color": "#B41D92",
              "text": "Скидка 31% на влажный корм Felix для кошек"
            }
          ],
          "availability_info": {
            "count": 29,
            "type": "available"
          },
          "short_name": "",
          "article": "25178",
          "id": "DCD64987-39D6-468D-AE26-C37EEFF894DC",
          "price": {
            "discount": 31,
            "price": 26.91,
            "original_price": 39
          }
        }
      ],
      "default_variant_article": "25178",
      "id": "D7D1492D-850F-4B72-B60C-9CB9B3B9D68D"
    },
    ...,
    {
      "id": "B10DACD6-DBF7-4DAB-912B-D8F39315794F",
      "name": "Felix Мясные ломтики Утка пауч для кошек 75 г",
      "default_variant_article": "29714",
      "code": "felix_myasnye_lomtiki_utka_pauch_dlya_koshek_75_g",
      "variants": [
        {
          "price": {
            "discount": 31,
            "price": 26.91,
            "original_price": 39
          },
          "article": "29714",
          "availability_info": {
            "type": "available",
            "count": 30
          },
          "id": "0D7272A1-5BCF-4C77-934E-0D1E3F8CE8E3",
          "badges": [
            {
              "text": "Скидка 31% на влажный корм Felix для кошек",
              "tint_color": "#FFFFFF",
              "background_color": "#B41D92",
              "title": "%"
            }
          ],
          "short_name": ""
        }
      ],
      "images": [
        {
          "original": "https://static.artemayer.ru/images/site/catalog/2_30332_1633417128.jpeg",
          "small": "https://static.artemayer.ru/images/site/catalog/192x200/2_30332_1633417128.jpeg",
          "medium": "https://static.artemayer.ru/images/site/catalog/480x480/2_30332_1633417128.jpeg",
          "large": "https://static.artemayer.ru/images/site/catalog/700x700/2_30332_1633417128.jpeg"
        }
      ],
      "allow_quick_buy": true
    }
  ],
  "sale_type": "online",
  "title": "Скидка 31% на влажный корм Felix для кошек",
  "id": "6BEAEAEB-5788-4A97-87D8-7E75D7E70E83",
  "end_date": "2024-12-31T00:00:00Z",
  "code": "skidka-31-na-vlazhnyi-korm-felix-dlia-koshek",
  "disclaimer": "*Количество акционного товара ограничено."
}
```

---

## Поиск

### Подсказки для поиска `GET api/v1/search/suggestions?query={USER_QUERY}`

**Request**

```zsh
curl --location 'localhost:8080/api/v1/search/suggestions?query=felix'
```

**Response**

```json
[
  {
    "text": "Felix",
    "highlighted_texts": [
      "Felix"
    ],
    "additional_text": "Кошки / Корма Сухие",
    "redirect": {
      "type": "products_collection",
      "products_set": {
        "category": {
          "code": "felix",
          "name": "Felix",
          "parent": {
            "code": "korma_sukhie",
            "has_children": true,
            "id": "E4960D2C-CA4C-466A-926E-F77CDA1059E9",
            "name": "Корма Сухие"
          },
          "id": "8656DDCA-C286-4873-8249-74C8BF6F212F",
          "has_children": false
        },
        "name": "Felix"
      }
    }
  },
  {
    "highlighted_texts": [
      "Felix"
    ],
    "redirect": {
      "type": "object",
      "object_id": "4681D399-39DC-4275-BA1A-3F9DD36A0A1A",
      "object_type": "Product"
    },
    "text": "Felix Суп Ягненок пауч для кошек 48 г"
  },
  ...,
  {
    "highlighted_texts": [
      "Felix"
    ],
    "text": "Felix Аппетитные кусочки Форель в желе пауч для кошек 75 г",
    "redirect": {
      "type": "object",
      "object_id": "D105546B-99C1-4802-99D6-A3AF98D4FCFE",
      "object_type": "Product"
    }
  }
]
```

---

### Популярные запросы поиска `GET api/v1/search/popular_searches`

**Request**

```zsh
curl --location 'localhost:8080/api/v1/search/popular_searches'
```

**Response**

```json
[
  {
    "redirect": {
      "type": "object",
      "object_id": "7D4FD6CD-B783-461F-9153-A39643F01F7C",
      "object_type": "Product"
    },
    "text": "Sirius Kitten Индейка для котят"
  },
  {
    "text": "AlphaPet Sensitive Adult Ягненок для кошек",
    "redirect": {
      "object_id": "A5B9E36B-443A-4939-A435-2318E1A76305",
      "object_type": "Product",
      "type": "object"
    }
  },
  ...,
  {
    "text": "Лежанка Pride Джокер сиреневая для животных 50*47 см",
    "redirect": {
      "type": "object",
      "object_id": "20605362-EAAC-41AF-B8FE-D7AA7F787229",
      "object_type": "Product"
    }
  }
]
```

---

## Подсказки [Адреса]

### Подсказка по улице `GET api/v1/suggestions/addresses/streets?query={USER_QUERY}&city_id={USER_CITY_ID}`

**Request**

```zsh
curl --location 'localhost:8080/api/v1/suggestions/addresses/streets?query=%D0%9A%D1%80%D0%B0&city_id=8dea00e3-9aab-4d8e-887c-ef2aaa546456' \
--header 'Content-Type: application/json;charset=UTF-8' \
--header 'Authorization: Token Ld0J7jrtrJMnsL2dVMTINP2n/9e7Ps472125NTESOeg='
```

**Response**

```json
[
  {
    "highlighted_text": "Кра",
    "text": "г Новосибирск, Краснояровское шоссе",
    "id": "ac933f6c-b009-453a-b936-967d09f6017a"
  },
  {
    "id": "b1ca4b4d-8675-409f-b524-635c4a3b785b",
    "text": "г Новосибирск, Красный пр-кт",
    "highlighted_text": "Кра"
  },
  ...,
  {
    "text": "г Новосибирск, ул Красный Факел",
    "id": "42745de2-2a72-4b2e-a1e7-26870d508d2f",
    "highlighted_text": "Кра"
  }
]
```

---

### Подсказка по дому `GET api/v1/suggestions/addresses/houses?query={USER_QUERY}&street_id={PREV_SUGGESTION_STREET_ID}`

**Request**

```zsh
curl --location 'localhost:8080/api/v1/suggestions/addresses/houses?query=47&street_id=ed57aab6-f28f-4e0f-814e-51bba403eae3' \
--header 'Content-Type: application/json;charset=UTF-8' \
--header 'Authorization: Token Ld0J7jrtrJMnsL2dVMTINP2n/9e7Ps472125NTESOeg='
```

**Response**

```json
[
  {
    "highlighted_text": "47",
    "text": "г Новосибирск, пр-кт Карла Маркса, д 47"
  },
  {
    "text": "г Новосибирск, пр-кт Карла Маркса, д 47/1",
    "highlighted_text": "47"
  },
  {
    "text": "г Новосибирск, пр-кт Карла Маркса, д 47/2",
    "highlighted_text": "47"
  }
]
```

---

### Подсказка по квартире `GET api/v1/suggestions/addresses/flats?query={USER_QUERY}&street_id={PREV_SUGGESTION_STREET_ID}`

**Request**

```zsh
curl --location 'localhost:8080/api/v1/suggestions/addresses/flats?query=%D0%B4%2047%203&street_id=ed57aab6-f28f-4e0f-814e-51bba403eae3' \
--header 'Content-Type: application/json;charset=UTF-8' \
--header 'Authorization: Token Ld0J7jrtrJMnsL2dVMTINP2n/9e7Ps472125NTESOeg='
```

**Response**

```json
[
  {
    "highlighted_text": "д 47 3",
    "text": "г Новосибирск, ул Красина, д 47, кв 3"
  },
  {
    "text": "г Новосибирск, ул Красина, д 47, кв 30",
    "highlighted_text": "д 47 3"
  },
  ...,
  {
    "highlighted_text": "д 47 3",
    "text": "г Новосибирск, ул Красина, д 47/1, кв 37"
  }
]
```

---

### Полный адрес `POST api/v1/suggestions/addresses`

**Request**

```zsh
curl --location 'localhost:8080/api/v1/suggestions/addresses' \
--header 'Content-Type: application/json;charset=UTF-8' \
--header 'Authorization: Ld0J7jrtrJMnsL2dVMTINP2n/9e7Ps472125NTESOeg=' \
--data '{
    "city": {
        "id": "8dea00e3-9aab-4d8e-887c-ef2aaa546456",
        "name": "Новосибирск"
    },
    "street": "ул Карла Маркса",
    "house": "д 47",
    "flat": "кв 3",
    "entrance": "1",
    "floor": "1"
}'
```

**Response**

```json
{
  "flat": "кв 3",
  "floor": "эт эт 1",
  "formatted": "г Новосибирск, пр-кт Карла Маркса, д 47, кв 3, п 1, эт 1",
  "entrance": "п 1",
  "street": "ул Карла Маркса",
  "house": "д 47",
  "city": {
    "name": "Новосибирск",
    "id": "8DEA00E3-9AAB-4D8E-887C-EF2AAA546456"
  }
}
```

---

## Подсказки [ФИО]

### Фамилия `GET api/v1/suggestions/fullname/surname?query={USER_QUERY}`

**Request**

```zsh
curl --location 'localhost:8080/api/v1/suggestions/fullname/surname?query=%D0%A1%D0%B2%D0%B5' \
--header 'Content-Type: application/json;charset=UTF-8'
```

**Response**

```json
[
  {
    "highlighted_text": "Све",
    "text": "Светлова",
    "gender": "woman"
  },
  {
    "gender": "woman",
    "text": "Светличная",
    "highlighted_text": "Све"
  },
  ...,
  {
    "highlighted_text": "Све",
    "gender": "woman",
    "text": "Светова"
  }
]
```

---

### Имя `GET api/v1/suggestions/fullname/name?query={USER_QUERY}`

**Request**

```zsh
curl --location 'localhost:8080/api/v1/suggestions/fullname/name?query=%D0%9D%D0%B8%D0%BA' \
--header 'Content-Type: application/json;charset=UTF-8'
```

**Response**

```json
[
  {
    "text": "Николай",
    "highlighted_text": "Ник",
    "gender": "man"
  },
  {
    "gender": "man",
    "text": "Никита",
    "highlighted_text": "Ник"
  },
  ...,
  {
    "highlighted_text": "Ник",
    "text": "Никас",
    "gender": "man"
  }
]
```

---

### Отчество `GET api/v1/suggestions/fullname/patronymic?query={USER_QUERY}`

**Request**

```zsh
curl --location 'localhost:8080/api/v1/suggestions/fullname/patronymic?query=%D0%93%D1%80%D0%B8' \
--header 'Content-Type: application/json;charset=UTF-8'
```

**Response**

```json
[
  {
    "gender": "woman",
    "highlighted_text": "Гри",
    "text": "Григорьевна"
  },
  {
    "text": "Григорьевич",
    "gender": "man",
    "highlighted_text": "Гри"
  },
  ...,
  {
    "gender": "woman",
    "highlighted_text": "Гри",
    "text": "Григоевна"
  }
]
```

---

## Пользователь

### Регистрация пользователя `POST api/v1/users/create`

**Request**

```zsh
curl --location 'localhost:8080/api/v1/users/create' \
--header 'Content-Type: application/json' \
--data-raw '{
    "surname": "Userson",
    "name": "User",
    "patronymic": "Usersed",
    "email": "user@example.com",
    "phone": "79139139113",
    "gender": "man",
    "password": "uNhsyBu28d",
    "confirm_password": "uNhsyBu28d"
}'
```
  
**Response**

```json
{
  "id": "60FFE4F7-FE33-4722-9386-04B9601F2918",
  "surname": "Userson",
  "name": "User",
  "patronymic": "Usersed",
  "phone": "79139139113",
  "email": "user@example.com",
  "gender": "man",
  "authentication": {
    "token": "RhasWbrZGrUw7xfwxqDQExiq+KENqy95VHbpuytX0Rs=",
    "expires_at": "2024-08-27T13:13:57Z"
  }
}
```

---

### Авторизация пользователя `POST api/v1/users/login`

**Request**
  
```zsh
curl --location --request POST 'localhost:8080/api/v1/users/login' \
--header 'Authorization: Basic Nzk5MzEyMnMzMzM6QWGjZGVmMTSxMQ=='
```

**Response**

```json
{
  "id": "60FFE4F7-FE33-4722-9386-04B9601F2918",
  "surname": "Userson",
  "name": "User",
  "patronymic": "Usersed",
  "phone": "79139139113",
  "email": "user@example.com",
  "gender": "man",
  "authentication": {
    "token": "RhasWbrZGrUw7xfwxqDQExiq+KENqy95VHbpuytX0Rs=",
    "expires_at": "2024-08-27T13:13:57Z"
  }
}
```

---

### Текущий пользователь `GET api/v1/users` Текущий пользователь

**Request**
  
```zsh
curl --location 'localhost:8080/api/v1/users' \
--header 'Authorization: Token RhasWbrZGrUw7xfwxqDQExiq+KENqy95VHbpuytX0Rs='
```

**Response**

```json
{
  "id": "60FFE4F7-FE33-4722-9386-04B9601F2918",
  "surname": "Userson",
  "name": "User",
  "patronymic": "Usersed",
  "phone": "79139139113",
  "email": "user@example.com",
  "gender": "man"
}
```

---

### Адрес пользователя `GET api/v1/users/address`

**Request**
  
```zsh
curl --location 'localhost:8080/api/v1/users/address' \
--header 'Authorization: Token RhasWbrZGrUw7xfwxqDQExiq+KENqy95VHbpuytX0Rs='
```

**Response**

```json
{
  "floor": "8",
  "street": "Нестрова",
  "house": "19",
  "formatted": "Москва, Нестрова, 19, 124",
  "entrance": "4",
  "city": {
    "name": "Москва",
    "id": "8DEA00E3-9AAB-4D8E-887C-EF2AAA546456"
  },
  "flat": "124"
}
```

---

### Изменение данных пользователя `POST api/v1/users/edit`

**Request**

Все поля тела запроса опциональны, отправляются те, которые подлежат изменению 

```zsh
curl --location 'localhost:8080/api/v1/users/edit' \
--header 'Content-Type: application/json' \
--data-raw '{
    "email": "user-user@example.com"
}'
```
  
**Response**

```json
{
  "id": "60FFE4F7-FE33-4722-9386-04B9601F2918",
  "surname": "Userson",
  "name": "User",
  "patronymic": "Usersed",
  "phone": "79139139113",
  "email": "user-user@example.com",
  "gender": "man"
}
```

---

### Обновление токена `POST api/v1/users/refresh_token`

**Request**

```zsh
curl --location --request POST 'localhost:8080/api/v1/users/refresh_token' \
--header 'Authorization: Token RhasWbrZGrUw7xfwxqDQExiq+KENqy95VHbpuytX0Rs='
```
  
**Response**

```json
{
  "id": "60FFE4F7-FE33-4722-9386-04B9601F2918",
  "surname": "Userson",
  "name": "User",
  "patronymic": "Usersed",
  "phone": "79139139113",
  "email": "user@example.com",
  "gender": "man",
  "authentication": {
    "token": "Ld0J7jrtrJMnsL2dVMTINP2n/9e7Ps472125NTESOeg=",
    "expires_at": "2024-08-27T13:13:57Z"
  }
}
```

---

### Удаление аккаунта пользователя `POST api/v1/users/delete`

**Request**

```zsh
curl --location --request POST 'localhost:8080/api/v1/users/delete' \
--header 'Authorization: Token Ld0J7jrtrJMnsL2dVMTINP2n/9e7Ps472125NTESOeg='
```
  
**Response**

```json
{}
}
```

---

### Выход из аккаунта `POST api/v1/users/logout`

**Request**

```zsh
curl --location --request POST 'localhost:8080/api/v1/users/logout' \
--header 'Authorization: Token Ld0J7jrtrJMnsL2dVMTINP2n/9e7Ps472125NTESOeg='
```
  
**Response**

```json
{}
}
```

---

## Заказы чекаут

### Доступные даты доставки `GET api/v1/checkout/available_dates`

**Request**

```zsh
curl --location 'localhost:8080/api/v1/checkout/available_dates' \
--header 'X-City-Id: 8dea00e3-9aab-4d8e-887c-ef2aaa546456' \
--header 'Authorization: Token Ld0J7jrtrJMnsL2dVMTINP2n/9e7Ps472125NTESOeg='
```
  
**Response**

```json
[
  {
    "availableTimeIntervals": [
      {
        "to": "14:00",
        "from": "10:00",
        "id": "28547C87-F528-4776-8C5E-1E65DC1D4DAE"
      },
      {
        "from": "14:00",
        "to": "18:00",
        "id": "4B463D07-CCCE-47A0-875B-3409C4462BCD"
      },
      {
        "id": "0C615E06-24E1-42C8-BC4D-7F0A370E65BF",
        "from": "18:00",
        "to": "23:00"
      }
    ],
    "date": "2024-08-27"
  },
  ...,
  {
    "availableTimeIntervals": [
      {
        "from": "10:00",
        "to": "14:00",
        "id": "28547C87-F528-4776-8C5E-1E65DC1D4DAE"
      },
      {
        "id": "4B463D07-CCCE-47A0-875B-3409C4462BCD",
        "from": "14:00",
        "to": "18:00"
      },
      {
        "from": "18:00",
        "id": "0C615E06-24E1-42C8-BC4D-7F0A370E65BF",
        "to": "23:00"
      }
    ],
    "date": "2024-08-30"
  }
]
```

---

### Доступные методы покупки `GET api/v1/checkout/available_deliveries`

**Request**

```zsh
curl --location 'localhost:8080/api/v1/checkout/available_deliveries' \
--header 'X-City-Id: 8dea00e3-9aab-4d8e-887c-ef2aaa546456' \
--header 'Authorization: Token Ld0J7jrtrJMnsL2dVMTINP2n/9e7Ps472125NTESOeg='
```
  
**Response**

```json
[
  {
    "subtitle": "заказ от 500 ₽",
    "type": "courier",
    "title": "Доставка курьером"
  }
]
```

---

### Проверка доступности всех товаров из корзины `POST api/v1/checkout/check_availability_and_calculate_amount`

**Request**

```zsh
curl --location 'localhost:8080/api/v1/checkout/check_availability_and_calculate_amount' \
--header 'X-City-Id: 8dea00e3-9aab-4d8e-887c-ef2aaa546456' \
--header 'Content-Type: application/json' \
--header 'Authorization: Token Ld0J7jrtrJMnsL2dVMTINP2n/9e7Ps472125NTESOeg=' \
--data '{
    "delivery": {
        "type": "courier"
    }
}'
```
  
**Response**

```json
{
  "items": [
    {
      "count": 1,
      "variant_name": "5 кг",
      "amount": {
        "price": 3998,
        "original_price": 3998
      },
      "product_id": "9681E266-5D23-446A-B18A-47303BEAF04E",
      "article": "39046",
      "image": {
        "small": "https://static.artemayer.ru/images/site/catalog/192x200/2_64706e30d5d78.jpeg",
        "large": "https://static.artemayer.ru/images/site/catalog/700x700/2_64706e30d5d78.jpeg",
        "original": "https://static.artemayer.ru/images/site/catalog/2_64706e30d5d78.jpeg",
        "medium": "https://static.artemayer.ru/images/site/catalog/480x480/2_64706e30d5d78.jpeg"
      },
      "badges": [
        {
          "tint_color": "#FFFFFF",
          "title": "Новинка",
          "background_color": "#66CC00"
        }
      ],
      "price": {
        "price": 3998,
        "original_price": 3998
      },
      "product_name": "Wonderfur Sterilised Курица/индейка для кошек",
      "availability_info": {
        "type": "available",
        "count": 3
      },
      "id": "F997B623-4459-4838-B4DC-9360DDD51D4E"
    }
  ],
  "summaries": [
    {
      "type": "ITEMS_WITHOUT_DISCOUNT",
      "name": "Товары без скидки",
      "value": 3998
    },
    {
      "name": "Доставка",
      "type": "DELIVERY",
      "value": 39
    },
    {
      "type": "TOTAL",
      "name": "Итого:",
      "value": 4037
    }
  ],
  "id": "70DC6034-5567-4830-A3EC-D1B07A14582C"
}
```

---

### Оформить заказ `POST api/v1/checkout/purchase`

**Request**

```zsh
curl --location 'localhost:8080/api/v1/checkout/purchase' \
--header 'X-City-Id: 8dea00e3-9aab-4d8e-887c-ef2aaa546456' \
--header 'Content-Type: application/json' \
--header 'Authorization: Token Ld0J7jrtrJMnsL2dVMTINP2n/9e7Ps472125NTESOeg=' \
--data-raw '{
    "comment": "Упакуйте красиво!",
    "client": {
        "surname": "Usered",
        "phone": "79139139113",
        "name": "User",
        "email": "user-user@example.com"
    },
    "delivery": {
        "delivery_date": "25.08.2024",
        "delivery_time_interval": {
            "id": "4b463d07-ccce-47a0-875b-3409c4462bcd",
            "from": "14:00",
            "to": "18:00"
        },
        "type": "courier",
        "address": {
            "floor": "4",
            "flat": "1",
            "city": {
                "id": "8dea00e3-9aab-4d8e-887c-ef2aaa546456",
                "name": "Новосибирск"
            },
            "street": "Карла Маркса",
            "house": "47/1",
            "entrance": "1"
        }
    },
    "payment_type": "card"
}'
```
  
**Response**

```json
{
  "order_number": "1000053"
}
```

---

## Заказы пользователя

### Заказы пользователя `GET api/v1/orders`

**Request**

```zsh
curl --location 'localhost:8080/api/v1/orders' \
--header 'X-City-Id: 8dea00e3-9aab-4d8e-887c-ef2aaa546456' \
--header 'Authorization: Token Ld0J7jrtrJMnsL2dVMTINP2n/9e7Ps472125NTESOeg='
```
  
**Response**

```json
{
  "paginationInfo": {
    "total_count": 4,
    "page": 1,
    "per_page": 20
  },
  "results": [
    {
      "id": "2AB6F45E-54C0-4EC6-9894-C97971A02416",
      "number": 1000039,
      "status": "Выполнен",
      "order_date": "2024-08-24",
      "items_previews": [
        {
          "id": "A7AC48EE-4F87-4CBB-BC32-5C8F2595BC1E",
          "image": {
            "large": "https://static.artemayer.ru/images/site/catalog/700x700/2_64706e30d5d78.jpeg",
            "small": "https://static.artemayer.ru/images/site/catalog/192x200/2_64706e30d5d78.jpeg",
            "original": "https://static.artemayer.ru/images/site/catalog/2_64706e30d5d78.jpeg",
            "medium": "https://static.artemayer.ru/images/site/catalog/480x480/2_64706e30d5d78.jpeg"
          }
        },
        {
          "id": "B984D927-ABD5-42A4-A78D-EAAEFB33AADC",
          "image": {
            "large": "https://static.artemayer.ru/images/site/catalog/700x700/2_650bc783a9c07.jpeg",
            "small": "https://static.artemayer.ru/images/site/catalog/192x200/2_650bc783a9c07.jpeg",
            "medium": "https://static.artemayer.ru/images/site/catalog/480x480/2_650bc783a9c07.jpeg",
            "original": "https://static.artemayer.ru/images/site/catalog/2_650bc783a9c07.jpeg"
          }
        }
      ],
      "repeat_allowed": true,
      "status_code": "COMPLETED",
      "cancelable": false,
      "summaries": [
        {
          "type": "ITEMS_WITHOUT_DISCOUNT",
          "name": "Товары без скидки",
          "value": 10196
        },
        {
          "name": "Доставка",
          "type": "DELIVERY",
          "value": 39
        },
        {
          "type": "TOTAL",
          "name": "Итого:",
          "value": 10235
        }
      ],
      "can_be_paid_online": false,
      "paid": true
    },
    ...,
    {
      "id": "5DC43798-4842-43E4-A573-013F1230CA5C",
      "can_be_paid_online": false,
      "order_date": "2024-08-22",
      "cancelable": false,
      "status_code": "CANCELED",
      "status": "Отменен",
      "paid": false,
      "summaries": [
        {
          "name": "Товары без скидки",
          "value": 10196,
          "type": "ITEMS_WITHOUT_DISCOUNT"
        },
        {
          "name": "Доставка",
          "type": "DELIVERY",
          "value": 39
        },
        {
          "name": "Итого:",
          "type": "TOTAL",
          "value": 10235
        }
      ],
      "repeat_allowed": true,
      "items_previews": [
        {
          "image": {
            "large": "https://static.artemayer.ru/images/site/catalog/700x700/2_64706e30d5d78.jpeg",
            "small": "https://static.artemayer.ru/images/site/catalog/192x200/2_64706e30d5d78.jpeg",
            "medium": "https://static.artemayer.ru/images/site/catalog/480x480/2_64706e30d5d78.jpeg",
            "original": "https://static.artemayer.ru/images/site/catalog/2_64706e30d5d78.jpeg"
          },
          "id": "1A555970-9C6D-49B2-AE29-6CF4EFF5157C"
        },
        {
          "image": {
            "small": "https://static.artemayer.ru/images/site/catalog/192x200/2_650bc783a9c07.jpeg",
            "medium": "https://static.artemayer.ru/images/site/catalog/480x480/2_650bc783a9c07.jpeg",
            "large": "https://static.artemayer.ru/images/site/catalog/700x700/2_650bc783a9c07.jpeg",
            "original": "https://static.artemayer.ru/images/site/catalog/2_650bc783a9c07.jpeg"
          },
          "id": "3483B7D1-6DED-46C4-98A3-238F1F42DB06"
        }
      ],
      "number": 1000021
    }
  ]
}
```

---

### Конкретный заказ `GET api/v1/orders/{ORDER_ID}`

**Request**

```zsh
curl --location 'localhost:8080/api/v1/orders/1000039' \
--header 'X-City-Id: 8dea00e3-9aab-4d8e-887c-ef2aaa546456' \
--header 'Authorization: Token Ld0J7jrtrJMnsL2dVMTINP2n/9e7Ps472125NTESOeg='
```
  
**Response**

```json
{
  "comment": "Упакуйте красиво!",
  "cancelable": false,
  "client": {
    "patronymic": "Useres",
    "name": "User",
    "surname": "Usered",
    "email": "user-user@example.com",
    "phone": "79139139113"
  },
  "order_date": "2024-08-24",
  "paid": true,
  "number": 1000039,
  "can_be_paid_online": false,
  "status": "Выполнен",
  "payment_type": "card",
  "items": [
    {
      "product_id": "9681E266-5D23-446A-B18A-47303BEAF04E",
      "price": {
        "price": 3998,
        "original_price": 3998
      },
      "product_name": "Wonderfur Sterilised Курица/индейка для кошек",
      "image": {
        "small": "https://static.artemayer.ru/images/site/catalog/192x200/2_64706e30d5d78.jpeg",
        "large": "https://static.artemayer.ru/images/site/catalog/700x700/2_64706e30d5d78.jpeg",
        "medium": "https://static.artemayer.ru/images/site/catalog/480x480/2_64706e30d5d78.jpeg",
        "original": "https://static.artemayer.ru/images/site/catalog/2_64706e30d5d78.jpeg"
      },
      "availability_info": {
        "type": "available",
        "count": 3
      },
      "article": "39046",
      "badges": [
        {
          "tint_color": "#FFFFFF",
          "background_color": "#66CC00",
          "title": "Новинка"
        }
      ],
      "count": 1,
      "variant_name": "5 кг",
      "amount": {
        "original_price": 3998,
        "price": 3998
      },
      "id": "A7AC48EE-4F87-4CBB-BC32-5C8F2595BC1E"
    },
    {
      "amount": {
        "price": 6198,
        "original_price": 6198
      },
      "article": "39052",
      "availability_info": {
        "count": 3,
        "type": "available"
      },
      "variant_name": "10 кг",
      "price": {
        "original_price": 6198,
        "price": 6198
      },
      "count": 1,
      "product_id": "278986E6-7568-4362-A9CE-9C04A485F612",
      "id": "B984D927-ABD5-42A4-A78D-EAAEFB33AADC",
      "product_name": "Wonderfur Adult All breeds Говядина/Рис для собак",
      "image": {
        "medium": "https://static.artemayer.ru/images/site/catalog/480x480/2_650bc783a9c07.jpeg",
        "large": "https://static.artemayer.ru/images/site/catalog/700x700/2_650bc783a9c07.jpeg",
        "original": "https://static.artemayer.ru/images/site/catalog/2_650bc783a9c07.jpeg",
        "small": "https://static.artemayer.ru/images/site/catalog/192x200/2_650bc783a9c07.jpeg"
      },
      "badges": []
    }
  ],
  "summaries": [
    {
      "value": 10196,
      "type": "ITEMS_WITHOUT_DISCOUNT",
      "name": "Товары без скидки"
    },
    {
      "type": "DELIVERY",
      "value": 39,
      "name": "Доставка"
    },
    {
      "name": "Итого:",
      "value": 10235,
      "type": "TOTAL"
    }
  ],
  "delivery": {
    "address": {
      "street": "Карла Маркса",
      "city": {
        "id": "8DEA00E3-9AAB-4D8E-887C-EF2AAA546456",
        "name": "Новосибирск"
      },
      "formatted": "Новосибирск, Карла Маркса, 47, 4",
      "flat": "4",
      "house": "47",
      "floor": "1",
      "entrance": "1"
    },
    "delivery_time_interval": {
      "id": "4B463D07-CCCE-47A0-875B-3409C4462BCD",
      "to": "18:00",
      "from": "14:00"
    },
    "type": "courier",
    "delivery_date": "25.08.2024"
  },
  "status_code": "COMPLETED",
  "repeat_allowed": true,
  "id": "2AB6F45E-54C0-4EC6-9894-C97971A02416"
}
```

---

### Отменить заказ `POST api/v1/orders/{ORDER_ID}/cancel`

**Request**

```zsh
curl --location --request POST 'localhost:8080/api/v1/orders/1000041/cancel' \
--header 'X-City-Id: 8dea00e3-9aab-4d8e-887c-ef2aaa546456' \
--header 'Authorization: Token Ld0J7jrtrJMnsL2dVMTINP2n/9e7Ps472125NTESOeg='
```
  
**Response**

```json
{}
```

---

### Повторить заказ `POST api/v1/orders/{ORDER_ID}/repeat`

**Request**

```zsh
curl --location --request POST 'localhost:8080/api/v1/orders/1000021/repeat' \
--header 'X-City-Id: 8dea00e3-9aab-4d8e-887c-ef2aaa546456' \
--header 'Authorization: Token Ld0J7jrtrJMnsL2dVMTINP2n/9e7Ps472125NTESOeg='
```
  
**Response**

```json
{
  "id": "70DC6034-5567-4830-A3EC-D1B07A14582C",
  "items": [
    {
      "article": "39046",
      "image": {
        "small": "https://static.artemayer.ru/images/site/catalog/192x200/2_64706e30d5d78.jpeg",
        "original": "https://static.artemayer.ru/images/site/catalog/2_64706e30d5d78.jpeg",
        "medium": "https://static.artemayer.ru/images/site/catalog/480x480/2_64706e30d5d78.jpeg",
        "large": "https://static.artemayer.ru/images/site/catalog/700x700/2_64706e30d5d78.jpeg"
      },
      "product_name": "Wonderfur Sterilised Курица/индейка для кошек",
      "price": {
        "price": 3998,
        "original_price": 3998
      },
      "badges": [
        {
          "tint_color": "#FFFFFF",
          "title": "Новинка",
          "background_color": "#66CC00"
        }
      ],
      "count": 2,
      "product_id": "9681E266-5D23-446A-B18A-47303BEAF04E",
      "availability_info": {
        "type": "available",
        "count": 3
      },
      "variant_name": "5 кг",
      "amount": {
        "original_price": 7996,
        "price": 7996
      },
      "id": "F997B623-4459-4838-B4DC-9360DDD51D4E"
    },
    {
      "variant_name": "10 кг",
      "image": {
        "original": "https://static.artemayer.ru/images/site/catalog/2_650bc783a9c07.jpeg",
        "medium": "https://static.artemayer.ru/images/site/catalog/480x480/2_650bc783a9c07.jpeg",
        "large": "https://static.artemayer.ru/images/site/catalog/700x700/2_650bc783a9c07.jpeg",
        "small": "https://static.artemayer.ru/images/site/catalog/192x200/2_650bc783a9c07.jpeg"
      },
      "id": "C03123D3-0C39-48E0-9BD6-B1A4064C6151",
      "availability_info": {
        "type": "available",
        "count": 3
      },
      "price": {
        "price": 6198,
        "original_price": 6198
      },
      "article": "39052",
      "amount": {
        "price": 12396,
        "original_price": 12396
      },
      "product_name": "Wonderfur Adult All breeds Говядина/Рис для собак",
      "count": 2,
      "product_id": "278986E6-7568-4362-A9CE-9C04A485F612",
      "badges": []
    }
  ],
  "summaries": [
    {
      "type": "ITEMS_WITHOUT_DISCOUNT",
      "value": 20392,
      "name": "Товары без скидки"
    },
    {
      "name": "Итого:",
      "type": "TOTAL",
      "value": 20392
    }
  ]
}
```

---

## Системное

### HEALTH-CHECK `GET health-check`

**Request**

```zsh
curl --location 'localhost:8080/health-check'
```

**Response**

```json
{}
```
