import Foundation

struct ProductDetails: Codable {
    let productId: Int
    let name: String
    let description: String
    let price: Price
    let variants: [Variant]
    let brandId: Int
    let brandName: String
    let images: [ProductImage]
    let isInStock: Bool
    let isAvailable: Bool
    let productCode: String
    let colour: String
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case productId
        case name
        case description
        case price
        case variants
        case brandId
        case brandName
        case images
        case isInStock
        case isAvailable
        case productCode
        case colour
        case url
    }
}

struct Price: Codable {
    let current: PriceValue
    let previous: PriceValue?
    let currency: String
    let isMarkedDown: Bool
    let discountPercentage: Int?
    
    enum CodingKeys: String, CodingKey {
        case current
        case previous
        case currency
        case isMarkedDown
        case discountPercentage
    }
}

struct PriceValue: Codable {
    let value: Double
    let text: String
}

struct Variant: Codable {
    let id: Int
    let sizeId: Int
    let brandSize: String
    let displaySizeText: String
    let isAvailable: Bool
    let colour: String
    let price: Price
    
    enum CodingKeys: String, CodingKey {
        case id
        case sizeId
        case brandSize
        case displaySizeText
        case isAvailable
        case colour
        case price
    }
}

struct ProductImage: Codable {
    let url: String
    let type: String
    let colour: String?
    let isPrimary: Bool
    
    enum CodingKeys: String, CodingKey {
        case url
        case type
        case colour
        case isPrimary
    }
} 