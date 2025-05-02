import UIKit

class DealsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var upperPriceLabel: UILabel!
    @IBOutlet var upperPriceSlider: UISlider!
    @IBOutlet var lowerPriceLabel: UILabel!
    @IBOutlet var lowerPriceSlider: UISlider!
    
    var store = DealStore()
    var deals = [Deal]()
    var upperPrice: String = "15"
    var lowerPrice: String = "0"
    var pageNumber = 0
    var isFetchingMore = false
    
    @IBAction func upperPriceSliderChanged(_ sender: UISlider) {
        let price = Int(sender.value)
        upperPrice = "\(price)"
        upperPriceLabel.text = "Upper price limit: $ \(price)"
        fetchDeals(forPage: 0)
    }
    
    @IBAction func lowerPriceSliderChanged(_ sender: UISlider) {
        let price = Int(sender.value)
        lowerPrice = "\(price)"
        lowerPriceLabel.text = "Lower price limit: $\(price)"
        fetchDeals(forPage: 0)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        upperPriceLabel.text = "Upper price limit: $15"
        lowerPriceLabel.text = "Lower price limit: $0"
        
        store.fetchDeals(storeID: "1", pageNumber: "0", lowerPrice: "0", upperPrice: "15") { (result) in
            switch result {
            case let .success(fetchedDeals):
                print("Fetched deals: \(fetchedDeals)")
                self.deals = fetchedDeals
            case let .failure(error):
                print("Error fetching deals: \(error)")
            }
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return deals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "DealTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! DealTableViewCell
        
        let deal = deals[indexPath.row]
        cell.configure(with: deal)
        
        return cell
    }
    
    //func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let selectedDeal = deals[indexPath.row]
            //let storyboard = UIStoryboard(name: "Main", bundle: nil)
            //if let detailVC = storyboard.instantiateViewController(withIdentifier: "DealDetailViewController") as? DealDetailViewController {
                //detailVC.deal = selectedDeal
                //navigationController?.pushViewController(detailVC, animated: true)
            //}
    //}
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height - 100, !isFetchingMore {
            isFetchingMore = true
            pageNumber += 1
            fetchDeals(forPage: pageNumber)
        }
    }
    
    func fetchDeals(forPage page: Int) {
        store.fetchDeals(storeID: "1", pageNumber: "\(page)", lowerPrice: lowerPrice, upperPrice: upperPrice) { [weak self] (result) in
            guard let self = self else {return}
            
            switch result {
            case let .success(fetchedDeals):
                if page == 0 {
                    self.deals = fetchedDeals
                } else {
                    self.deals.append(contentsOf: fetchedDeals)
                }
            case let .failure(error):
                print("Error fetching deals: \(error)")
            }
            self.isFetchingMore = false
            self.tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDealDetail",
           let detailVC = segue.destination as? DealDetailViewController,
           let indexPath = tableView.indexPathForSelectedRow {
            detailVC.deal = deals[indexPath.row]
        }
    }

}

