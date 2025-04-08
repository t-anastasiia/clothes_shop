import Foundation

struct ProductDetailed {
    let id: Int
    let name: String
    let description: String
    let price: String
    let imageUrl: String?
    let sizes: [SizeDetailed]
    let isInStock: Bool
    let isAvailable: Bool
}


struct SizeDetailed {
    let id: Int
    let brandSize: String
    let displayText: String
    let isAvailable: Bool
}
