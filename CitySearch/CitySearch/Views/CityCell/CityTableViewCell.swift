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
  
  func updateUI(data: City) {
    let cityName = data.name
    let countryName = data.country
    let Longitude = data.coord.lon
    let Latitude = data.coord.lat
    
    city.text = "\(cityName), \(countryName)"
    lon.text = "Longitude: \(Longitude)"
    lat.text = "Latitude: \(Latitude)"
  }
}
