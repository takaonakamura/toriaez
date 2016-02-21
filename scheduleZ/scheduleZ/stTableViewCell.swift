//
//  stTableViewCell.swift
//  scheduleZ
//
//  Created by 中村考男 on 2016/02/06.
//  Copyright © 2016年 tamagawa. All rights reserved.
//

import UIKit

class stTableViewCell: UITableViewCell {

    @IBOutlet weak var lblStDate: UILabel!
    @IBOutlet weak var lblStSTS: UILabel!
    @IBOutlet weak var lblStWS: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
