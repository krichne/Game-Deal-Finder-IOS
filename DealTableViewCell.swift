import UIKit

class DealTableViewCell: UITableViewCell {
    
    //@IBOutlet var titleLabel: UILabel!
    @IBOutlet var normalPriceLabel: UILabel!
    @IBOutlet var salePriceLabel: UILabel!
    @IBOutlet var thumbnailImageView: UIImageView!
    
    func configure(with deal: Deal) {
        //titleLabel.text = deal.title
        normalPriceLabel.text = "$\(deal.normalPrice)"
        salePriceLabel.text = "$\(deal.salePrice)"
        if let url = URL(string: deal.thumb), let data = try? Data(contentsOf: url) {
            thumbnailImageView.image = UIImage(data: data)
        }
    }
}

