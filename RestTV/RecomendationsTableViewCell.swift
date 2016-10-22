//
//  RecomendationsTableViewCell.swift
//  RestTV
//
//  Created by Анастасия on 13.10.16.
//  Copyright © 2016 Anastasia. All rights reserved.
//

import UIKit

class RecomendationsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var customImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        customImageView.image = UIImage(named: "zagl")
        nameLabel.text = nil
    }

}
