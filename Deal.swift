import Foundation

class Deal: Codable, Equatable {
    let title: String
    let salePrice: String
    let normalPrice: String
    let steamAppID: String
    let steamRatingPercent: String
    let dealID: String
    let gameID: String
    let storeID: String
    let thumb: String
    
    static func == (lhs: Deal, rhs: Deal) -> Bool {
        // Two Photos are the same if they have the same photoID
        return lhs.gameID == rhs.gameID
    }
    
    enum CodingKeys: String, CodingKey {
        case title
        case salePrice = "salePrice"
        case normalPrice = "normalPrice"
        case steamAppID = "steamAppID"
        case steamRatingPercent = "steamRatingPercent"
        case dealID = "dealID"
        case gameID = "gameID"
        case storeID = "storeID"
        case thumb = "thumb"
    }
    
}
