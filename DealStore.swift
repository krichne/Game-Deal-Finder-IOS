import UIKit

class DealStore {
    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    
    func fetchDeals(storeID: String, pageNumber: String, lowerPrice: String, upperPrice: String, completion: @escaping (Result<[Deal], Error>) -> Void) {
        let url = CheapSharkAPI.dealsURL(storeID: storeID, pageNumber: pageNumber, lowerPrice: lowerPrice, upperPrice: upperPrice)
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) { (data, response, error) in
            let result = self.processDealsRequest(data: data, error: error)
            OperationQueue.main.addOperation {
                completion(result)
            }
        }
        task.resume()
    }
    
    private func processDealsRequest(data: Data?, error: Error?) -> Result<[Deal], Error> {
        guard let jsonData = data else {
            return .failure(error!)
        }
        return CheapSharkAPI.deals(fromJSON: jsonData)
    }
}
