//
//  DetailViewController.swift
//  YelpApi
//
//  Created by Huy Lam on 22/03/2022.
//

import UIKit
import Kingfisher

extension UIActivityIndicatorView: Placeholder {
  
}

class DetailViewController: UIViewController {
  var business: Business!
  @IBOutlet weak var bizImageView: UIImageView!
  @IBOutlet weak var bizName: UILabel!
  @IBOutlet weak var bizRatingsLabel: UILabel!
  @IBOutlet weak var bizCategoriesLabel: UILabel!
  @IBOutlet weak var bizPriceLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let loadingView = UIActivityIndicatorView()
    loadingView.startAnimating()
    let url = URL(string: business.imageURL ?? "")
    bizImageView.kf.setImage(with: url, placeholder: loadingView)
    bizName.text = business.name
    bizRatingsLabel.text = String(format: "%.2f", business.rating ?? 0)
    bizCategoriesLabel.text = business.categoriesName
    bizPriceLabel.text = business.price
  }
  
}
