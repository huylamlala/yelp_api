//
//  LoadMoreCell.swift
//  YelpApi
//
//  Created by Huy Lam on 22/03/2022.
//

import UIKit

class LoadMoreCell: UITableViewCell {
  
  
  @IBOutlet weak var loadingView: UIActivityIndicatorView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
}
