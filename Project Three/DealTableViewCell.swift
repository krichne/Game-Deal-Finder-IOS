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
            
            guard let url = URL(string: deal.thumb) else { return }
            
            URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                guard let self = self, let data = data, error == nil else { return }
                DispatchQueue.main.async {
                    self.thumbnailImageView.image = UIImage(data: data)
                }
            }.resume()
        }
}

