import Foundation

struct Product {
    let id: Int
    let title: String
    let price: Double
    let description: String
    let category: String
    let image: URL
}

struct SizeDetailed {
    let brandSize: String
    let isAvailable: Bool
}
