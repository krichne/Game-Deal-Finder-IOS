import UIKit

class DealDetailViewController: UIViewController {
    @IBOutlet var dealTitleLabel: UILabel!
    @IBOutlet var dealPriceLabel: UILabel!
    @IBOutlet var dealRatingLabel: UILabel!
    @IBOutlet var dealSaleLabel: UILabel!
    @IBOutlet var dealIDLabel: UILabel!
        
    var deal: Deal! {
        didSet {
            navigationItem.title = deal.title
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        dealTitleLabel.text = "Title: \(deal.title)"
        dealRatingLabel.text = "Steam Store Rating: \(deal.steamRatingPercent)%"
        dealPriceLabel.text = "Retail Price: $\(deal.normalPrice)"
        dealSaleLabel.text = "Sale Price: $\(deal.salePrice)"
        dealIDLabel.text = "Link To Steam Store Page:\n\nPage:https://www.cheapshark.com/redirect?dealID=\(deal.dealID)"
    }

}
