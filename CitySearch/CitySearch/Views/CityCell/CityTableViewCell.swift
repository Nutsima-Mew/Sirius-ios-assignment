//
//  CityTableViewCell.swift
//  CitySearch
//
//  Created by NUTSIMA NONGYAI on 16/4/2565 BE.
//

import UIKit

class CityTableViewCell: UITableViewCell {
  
  public static let identifier = "CityCell"
  
  @IBOutlet private weak var city: UILabel!
  @IBOutlet private weak var lon: UILabel!
  @IBOutlet private weak var lat: UILabel!
  @IBOutlet private weak var view: UIView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
  func updateUI() {
    city.text = ","
    lon.text = ""
    lat.text = ""
  }
}
