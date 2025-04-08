//
//  ProductDTOs.swift
//  clothes_shop
//
//  Created by anastasiia talmazan on 2025-04-08.
//

import Foundation

struct ProductDTO: Codable {
    let productId: Int
    let name: String
    let description: String
    let price: PriceDTO
    let variants: [VariantDTO]
    let brandId: Int
    let brandName: String
    let images: [ProductImageDTO]
    let isNoSize: Bool
    let hasMultipleColoursInStock: Bool
    let hasMultiplePricesInStock: Bool
    let isInStock: Bool
    let isRestockingSoon: Bool
    let isOneSize: Bool
    let isAvailable: Bool
    let productCode: String
    let colour: String
    let shippingRestriction: String?
    let sku: String
    let url: String
    let offers: [String: String]?
    let isHazmat: Bool
    let restockingLeadTime: Int
}

struct PriceDTO: Codable {
    let current: PriceValueDTO
    let previous: PriceValueDTO?
    let xrp: PriceValueDTO?
    let currency: String
    let isMarkedDown: Bool
    let isOutletPrice: Bool
    let startDateTime: String
    let previousEndDate: String
    let lowestPriceInLast30DaysValue: Double?
    let lowestPriceInLast30DaysText: String?
    let lowestPriceInLast30DaysEndDate: String?
    let lowestPriceInLast30DaysPercentage: Double?
    let discountPercentage: Int?
}

struct PriceValueDTO: Codable {
    let value: Double
    let text: String
}

struct VariantDTO: Codable {
    let id: Int
    let name: String
    let sizeId: Int
    let brandSize: String
    let displaySizeText: String
    let sizeOrder: Int
    let isAvailable: Bool
    let colourWayId: Int
    let colour: String
    let isPrimary: Bool
    let ean: String
    let price: PriceDTO
}

struct ProductImageDTO: Codable {
    let url: String
    let type: String
    let colourWayId: Int?
    let colour: String?
    let isPrimary: Bool
}
