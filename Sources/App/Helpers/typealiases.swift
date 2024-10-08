//
//  typealiases.swift
//
//
//  Created by Artem Mayer on 10.07.2024.
//

import Foundation

typealias HEXColor = String

typealias AvailabilityInfo = ProductVariant.AvailabilityInfo
typealias AvailabilityType = AvailabilityInfo.AvailabilityType
typealias AvailabilityInfoDTO = ProductVariantDTO.AvailabilityInfoDTO

typealias Price = ProductVariant.Price
typealias PriceDTO = ProductVariantDTO.PriceDTO

typealias Badge = ProductVariant.Badge
typealias BadgeDTO = ProductVariantDTO.BadgeDTO

typealias ProductVariant = Product.ProductVariant
typealias ProductVariantDTO = ProductDTO.ProductVariantDTO

typealias PropertyValueDTO = ProductVariantDTO.PropertyValueDTO

typealias ProductProperty = Product.ProductProperty
typealias ProductPropertyDTO = ProductDTO.ProductPropertyDTO

typealias Section = Product.Section
typealias SectionType = Section.SectionType
typealias SectionDTO = ProductDTO.SectionDTO

typealias Redirect = MainBanner.Redirect
typealias RedirectDTO = MainBannerDTO.RedirectDTO

typealias RedirectType = Redirect.RedirectType
typealias ObjectType = Redirect.ObjectType

typealias ProductsSet = Redirect.ProductsSet
typealias ProductsSetDTO = RedirectDTO.ProductsSetDTO

typealias ImageDimension = Image.ImageDimension
typealias ImageDimensionDTO = ImageDTO.ImageDimensionDTO

typealias PlaceType = MainBanner.PlaceType

typealias UISettings = MainBanner.UISettings
typealias UISettingsDTO = MainBannerDTO.UISettingsDTO

typealias Spacing = UISettings.Spacing
typealias SpacingDTO = UISettingsDTO.SpacingDTO

typealias CornerRadius = UISettings.CornerRadius
typealias CornerRadiusDTO = UISettingsDTO.CornerRadiusDTO

typealias Metric = UISettings.Metric
typealias MetricDTO = UISettingsDTO.MetricDTO

typealias DeliveryType = Delivery.DeliveryType
typealias DeliveryTimeInterval = Delivery.DeliveryTimeInterval
typealias DeliveryTimeIntervalDTO = DeliveryDTO.DeliveryTimeIntervalDTO

typealias StatusCode = Order.StatusCode

typealias PaymentType = Order.PaymentType

typealias DiscountType = PromoCode.DiscountType

typealias SaleType = Sale.SaleType

typealias CityDTO = AddressDTO.CityDTO

typealias SuggestionsType = DaDataResponse.SuggestionsType

typealias CartRequestItem = CartRequest.CartDTO.Item

typealias Authentication = User.Authentication

typealias FiltersSort = FilterQueryRequest.Sort
