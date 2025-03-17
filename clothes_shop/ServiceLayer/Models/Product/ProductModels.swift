//
//  ProductModels.swift
//  clothes_shop
//
//  Created by anastasiia talmazan on 2025-03-17.
//

import Foundation

/// Главная обертка, содержащая данные, сообщение и возможную ошибку
struct ProductResponse: Decodable {
    let data: ProductData
    let message: String?
    let error: String?
}

/// Держит массив products и мета-информацию о пагинации
struct ProductData: Decodable {
    let products: [Product]
    let nbHits: Int
    let page: Int
    let nbPages: Int
    let perPage: Int
}

/// Представляет отдельный товар с его характеристиками
struct Product: Decodable {
    let productId: Int
    let name: String
    let boutiqueName: String
    let boutiqueUrlName: String
    let sellerId: String
    let boutiqueType: String
    let priceToPay: Double
    let listPrice: Double
    let primaryImageId: String
    let goLiveDate: Int
    let colour: String
    let material: String?
    let style: String?
    let vintageEra: String?
    let categoryName: String
    let productUrl: String
    let gender: String
    let brand: String
    let saleSection: String?
    let freeUkShipping: Bool
    let recommendationScore: Double?
    let sizes: [Size]
    let pageIdentifiers: [String]
    let imageUrl: String
    let sortedSizes: [String]
    let randomSortTieBreaker: String
    let boutiqueLocation: String
    let shipping: Shipping
    let boutiqueRating: Int
    let condition: String
    
    enum CodingKeys: String, CodingKey {
        case productId
        case name = "Name"
        case boutiqueName = "BoutiqueName"
        case boutiqueUrlName = "BoutiqueUrlName"
        case sellerId = "SellerId"
        case boutiqueType = "BoutiqueType"
        case priceToPay = "PriceToPay"
        case listPrice = "ListPrice"
        case primaryImageId = "PrimaryImageId"
        case goLiveDate = "GoLiveDate"
        case colour = "Colour"
        case material = "Material"
        case style = "Style"
        case vintageEra = "VintageEra"
        case categoryName = "CategoryName"
        case productUrl = "ProductUrl"
        case gender = "Gender"
        case brand = "Brand"
        case saleSection = "SaleSection"
        case freeUkShipping = "FreeUkShipping"
        case recommendationScore = "RecommendationScore"
        case sizes = "Sizes"
        case pageIdentifiers = "PageIdentifiers"
        case imageUrl = "ImageUrl"
        case sortedSizes = "SortedSizes"
        case randomSortTieBreaker = "RandomSortTieBreaker"
        case boutiqueLocation = "BoutiqueLocation"
        case shipping = "Shipping"
        case boutiqueRating = "BoutiqueRating"
        case condition = "Condition"
    }
}

/// Размеры товара
struct Size: Decodable {
    let id: Int
    let label: String
    
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case label = "Label"
    }
}

/// Данные о стоимости доставки в разные регионы
struct Shipping: Decodable {
    let ukStandard: Double?
    let ukExpress: Double?
    let europeEU: Double?
    let europeNonEU: Double?
    let restOfWorld: Double?
    let northAmerica: Double?
    let franceStandard: Double?
    let hungaryStandard: Double?
    let hungaryExpress: Double?
    let lithuaniaStandard: Double?
    let lithuaniaExpress: Double?
    
    enum CodingKeys: String, CodingKey {
        case ukStandard = "UK Standard"
        case ukExpress = "UK Express"
        case europeEU = "Europe EU"
        case europeNonEU = "Europe Non EU"
        case restOfWorld = "Rest of the World"
        case northAmerica = "North America"
        case franceStandard = "France Standard"
        case hungaryStandard = "Hungary Standard"
        case hungaryExpress = "Hungary Express"
        case lithuaniaStandard = "Lithuania Standard"
        case lithuaniaExpress = "Lithuania Express"
    }
}
