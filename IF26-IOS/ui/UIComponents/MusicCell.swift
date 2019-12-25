//
//  MusicCell.swift
//  IF26-IOS
//
//  Created by Laura Haegel on 18/12/2019.
//  Copyright © 2019 if26. All rights reserved.
//

import UIKit

class MusicCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var artist: UILabel!
    @IBOutlet weak var favBtn: UIButton!
    
    var favClosure: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    @IBAction func favClicked(_ sender: Any) {
        favClosure?()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
