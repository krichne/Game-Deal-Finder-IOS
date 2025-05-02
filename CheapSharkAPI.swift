import Foundation

struct CheapSharkAPI {
    
    private static let baseURLString = "https://www.cheapshark.com/api/1.0/deals?" //deals?storeID=1&upperPrice=15
    //No API key needed
    static func dealsURL(storeID: String, pageNumber: String, lowerPrice: String, upperPrice: String) -> URL {
        var components = URLComponents(string: baseURLString)!
        components.queryItems = [
            URLQueryItem(name: "storeID", value: storeID),
            URLQueryItem(name: "pageNumber", value: pageNumber),
            URLQueryItem(name: "lowerPrice", value: lowerPrice),
            URLQueryItem(name: "upperPrice", value: upperPrice)
        ]
        return components.url!
    }
    
    static func deals(fromJSON data: Data) -> Result<[Deal], Error> {
        do {
            let decoder = JSONDecoder()
            let deals = try decoder.decode([Deal].self, from: data)
            
            let filteredDeals = deals.filter { $0.normalPrice != $0.salePrice}
            return .success(filteredDeals)
        } catch {
            return .failure(error)
        }
    }
}

