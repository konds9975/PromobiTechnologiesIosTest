//
//  LocationListTableViewCell.swift
//  PromobiTechnologiesIosTest
//
//  Created by Kondya on 02/07/19.
//  Copyright © 2019 Fortune4. All rights reserved.
//

import UIKit

class LocationListTableViewCell: UITableViewCell {

    @IBOutlet weak var lattitudeLbl: UILabel!
    @IBOutlet weak var longitudeLbl: UILabel!
    @IBOutlet weak var batteryInfoLbl: UILabel!
    @IBOutlet weak var cpuUseagesLbl: UILabel!
    @IBOutlet weak var timeDateLbl: UILabel!
    
    
    func setModel(model:LocationInfo) {
        self.lattitudeLbl.attributedText = (model.lattitude ?? "NA").decorateText(sub: "Lattitude: ")
        self.longitudeLbl.attributedText = (model.longitude ?? "NA").decorateText(sub: "Longitude: ")
        self.batteryInfoLbl.attributedText = "\(model.battery)%".decorateText(sub: "Battery info: ")
        self.cpuUseagesLbl.attributedText = (model.cpuusages ?? "NA").decorateText(sub: "CPU useages: ")
        self.timeDateLbl.attributedText = (model.datetime?.toString() ?? "NA").decorateText(sub: "Date and time: ")
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
