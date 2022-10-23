//
//  MenuListTblCell.swift
//  DemoLocation
//
//  Created by shomil on 03/10/22.
//

import UIKit

class TripListTblCell: UITableViewCell {

    @IBOutlet weak var lblTripNo: UILabel!
    @IBOutlet weak var lblStartTime: UILabel!
    @IBOutlet weak var lblEndTime: UILabel!
    @IBOutlet weak var lblDistance: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
